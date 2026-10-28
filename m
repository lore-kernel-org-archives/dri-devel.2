Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4E606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CbQTH0Ny
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5739C10E526;
	Wed, 28 Oct 2026 01:19:35 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 294B810F8C9
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 01:19:29 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-35c76e9614aso699972eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 18:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793150368; x=1793755168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QGQE3LAYpEwlaN5IMebgHt/LGKiGCVPD/r8B3CD/Y/o=;
 b=CbQTH0NyHyoIWwBxr+u6TO5OMH1JFL5yOaj1MJYkmGQM7OePsU6msFXRs1dlKIPl1j
 eujg7ARgfxFx3b39gXqHx57b0f1EeLfTOkvYEVeUOesmxRHQu/nRCRR75ECKKkCwOJ4V
 BTGadqrdNtMCt3Xt02VhK0DD0xRIWu1OJ1W/qwSo0szOkn0E2CoptomJe9YKDwQ4WwPE
 rkDWXu4toHf7+FQ12T3UEncARX7MAmIwv6s4YwRyGrRdF+EgU7PiqlzSaLCqDOqy66xv
 wXVhtyARPpQleIWUL00xU61+nTxlInwUhfkk6clw/xyPeyIk/xDWz6QVDMWzJCzIScGi
 hYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793150368; x=1793755168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QGQE3LAYpEwlaN5IMebgHt/LGKiGCVPD/r8B3CD/Y/o=;
 b=xvRwpc5q7iTCExxeKkJEcK863ZuDYSA3wKiDx1jZhlNF6O6JaCfJsxYdCPZ/fpikEU
 mQE+I7P8GU38Z56xwTncng3V56qxTPcp19C3/1bdAXsRKMVyLZb47u+c6/nw6C5dm4Vh
 0FopOZfAjBKgZzM7fKcrxLiqwuGaJc6BCfhKh/sRN7fU3GoIViVixXajw6Vj2/m31wzI
 hJMyVHTfS2d1QtsrvNYy0CRQBrcQZ6wZQ/ZnK0jyxe5wmMnt2R5nGtIqGU+UMDx6GQjF
 KFn0O5sGMnUeifJgeCVdhgah3+X8+n20k8PKExV6uvzqjBHj/xt4X1lynsgYQbIk9GB0
 64wQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwS60/wqybaeEIX2TLna0B3YjtoE9KbYyipfgPHHfRwGaAaT1UKzCvw2RxrX6gLMExq2oGK1oSAEj8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKbCEWIv4m4QI7tqg6AfvH/IDmkRyyQRPDajG7Mne7wsKsxM1t2
 /jjUKWYvz/LUUdag5ZIw1fRn164H+GPPp3ssWybM3eIB8LgAplxqcps=
X-Gm-Gg: AYBFou1ZrX6ONdFJ8KHdz8GgiXkXjol6C7eaSRfiq1Pj9eFfI8IBXtvDjqBfB7TwsTe
 VSDdu6cC7UtEpm0375nrkVb5sAs+HHjA5vEFZjzs18aB+3Ae7/wxyXVe149FQ8TvyxFYQOH4J0q
 PcEqHuj8uQ7K0PYFI7jWI+qJ++O6YBI+yT2CA16ZP1uheturBBndlIo38H7xZbs+icL0KCzJQMf
 V10rzCxO73DQtIWlim4bzZc71vRBKcURlkYRrc45BGif+KFE3KwXiYzHzpysINm8TFD05ah2LgL
 I3Z1n4BhNcfAhdbcPgTYpSnwQY9HkjCg/LyHX+eNNbo7sTgOTJNiC8sskTADlf7EBcfRPn+XN4p
 r4cxVY2U8Vh3MGUntP3di7jKh09pmNqEvbqWViMaU5lAyNz7/Csqq+iG+A2d7oHyFmEHhW3DgJA
 36HGKdHbN5EAA+lTNVX7XZwLMFi499dgG3VQuSWhoByN5lqNuVUrM+FUft0Y4AyCqQ7UHcDoJPU
 vjZIP3znhFRQozE+fCryjaxankUJ0cdH8JL07mIkiu1ezYc47VAodQC050dCsSeCOHtYPUdx7Xi
 HjpkfP4tVfHkvbuav+8SdbsJL+lKJ1vxf+Zm2MroPC9RtmD9Bf2gyAAKFmSvcnzAttubQBXgccf
 g3xQOB1PmIQOF
X-Received: by 2002:a05:7300:fd0f:b0:367:363f:6fe4 with SMTP id
 5a478bee46e88-36a20440ad5mr1939920eec.32.1793150368183; 
 Tue, 27 Oct 2026 18:19:28 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.115.199])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2392ecfdsm821863eec.17.2026.10.27.18.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 18:19:27 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: atharvatiwarilinuxdev@gmail.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, bhelgaas@google.com, bp@alien8.de,
 christian.koenig@amd.com, dave.hansen@linux.intel.com, dev@deq.rocks,
 dri-devel@lists.freedesktop.org, hansg@kernel.org, harry.wentland@amd.com,
 helgaas@kernel.org, hpa@zytor.com, ilpo.jarvinen@linux.intel.com,
 kenneth.feng@amd.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, mingo@redhat.com,
 platform-driver-x86@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tglx@kernel.org, x86@kernel.org
Subject: Re: [PATCH 02/13] PCI: Disable pcie port and access on D3 on specific
 amd devices
Date: Tue, 27 Oct 2026 21:19:14 -0400
Message-ID: <20261028011915.8217-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028000841.6816-1-atharvatiwarilinuxdev@gmail.com>
References: <20261028000841.6816-1-atharvatiwarilinuxdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I did not know about, i will try to remove the ignore_access code, and
> will tell you the results, i added it as a failsafe

I tested, and yes it works without ignore_access code, but we still need no_pcie_port.


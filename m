Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F856606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 05:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=G/WLf6fi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB20F10E0A0;
	Tue, 17 Nov 2026 05:14:07 +0000 (UTC)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6461610E0A0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 05:14:02 +0000 (UTC)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-cdd9d0c9bbdso3162616a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794892442; x=1795497242;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YAuEpSxANSP7JcEdvtPeNUKnuMNx4G65SgK0sHR3xaQ=;
 b=sDyykm/DHm1U6flD/w7+wxpwWMKvEKF9hMeOigZ7cTdqpybqbnrr8yMOg5dC+hy2HS
 HBgmfO4vFc4G0Wuk8Ro+M3iKKjMuYtqdW4nzkaigW+SNnR/4Ugo8Nj4vn0ONUPYD0q4l
 g+RX0ieM47AKg5/m3yFHwwr2gzTcm5Q032C96+6ndxYbYP4ZJGVTuabAqoyFjA2G6X2c
 cKyqmsNK2h8GCdufauykfUzekZXw0k5D9L93MgEct/U/e6blmqu51pNA+KjiRnNEYZCE
 NfJazYmajH+pfVNlvNTSQjUtjmxkNbPHEoBEueGCfYHdjV7vW7hML5BBsKRMfGnlmaSI
 tQ4g==
X-Gm-Message-State: APuU4Z+1ycDfUZfwoNtukWLavFRP6l8qeaZ6sEYKcIJMevT5fPBUyTI6
 TOYrcsyBqF31ZkRfgtUY0WO8CSESvY1TEINkU2SWU6x5SIl37jrUcIMPqCy7Q6ZlpBSHfet+9TJ
 HwSFs6EJacZo1sZkvbcg4WNq6MSKvPu+YbO5gWlul1/793TqV2gN8Lm8LT+1ctn2Sv24GJ4umtP
 XlOrkPx9iLvbAwfrnns2k7+mM/1VUEE1WH65M6kzUZxyI6MvOFPVhhlnp1rHzla67jmW+fB6YH9
 pwniteCRQIcOueaeAv4
X-Gm-Gg: AZFdTZcpR6kYySH3b6+Y0GqL+bFBn6m4pWNmIl+4cBxcVvetU98Cs64uuAZVZ79AGOE
 Hv4P5AubGoB/MTxbnYvbv4hmIXV9p4o6iuaGcS8uEiyoOPkWno+y9AqIOVL1CLFttJPAth7is/9
 48FoGxcrEra2aZZpnzcnxvzP5sWrNNrj/As8LyIY/ySfOnoo648WFpklP9BUVh7T4QcRr1hnJ37
 PLrLbek2R7QXGQQyXmOzjcu0diOS/FzTg8M59jMEXTbvvbAJWqPe7xentoM216tQZFIHkXPvArb
 X5yzsbCk9ajB0zVmKkCaZ+CDuNfoALAhXvD6l1aDqAQV2PvWtXiB9gMXRXEXIGeteTVfUv4XFP2
 qcDIqfBSRGj4Z6aWIVI3OSvD/QQLXhACKDuZRLMgEOgX/pxaATTtKNUut0FX8kq/2ZOHS9lEfF1
 hCPiW4fUH54cbcmTwM9xhMj8mhcTvhRSO1
X-Received: by 2002:a17:90a:e7ce:b0:3a4:f75d:d1a3 with SMTP id
 98e67ed59e1d1-3b1b0ba53ecmr11887548a91.32.1794892441711; 
 Mon, 16 Nov 2026 21:14:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b1b3fbf607sm5598446a91.4.2026.11.16.21.14.01
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 21:14:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd3b9e70f88so4770074a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794892440; x=1795497240;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YAuEpSxANSP7JcEdvtPeNUKnuMNx4G65SgK0sHR3xaQ=;
 b=G/WLf6fihlLMz2vDbVgFtP3MBXMZNATGK/KAJUYh2kXL331za++gPwFH31KcH6j6JX
 GSe5TDRDS4BJ2XQMN3m88L+99BkT4pYGha1vaqMODke+nOV8Ga298ZtX9VgZamKenPEV
 k/YJy8xkx7J5FoQGLdCEIfTU0Yi+iIuC+wnf4=
X-Received: by 2002:a05:6a21:66c4:b0:3fa:ab6:3879 with SMTP id
 adf61e73a8af0-3fa0ab63fe6mr6768573637.49.1794892439737; 
 Mon, 16 Nov 2026 21:13:59 -0800 (PST)
X-Received: by 2002:a05:6a21:66c4:b0:3fa:ab6:3879 with SMTP id
 adf61e73a8af0-3fa0ab63fe6mr6768558637.49.1794892439322; 
 Mon, 16 Nov 2026 21:13:59 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc1898afbsm5055323a12.19.2026.11.16.21.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 21:13:58 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	maaz.mombasawala@broadcom.com
Subject: Re: [PATCH v2 1/2] drm/vmwgfx: return an error when a shared GB
 surface has no backup buffer
Date: Tue, 17 Nov 2026 00:13:54 -0500
Message-ID: <179487959549.2515856.17357150217025850312@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007212051.2574235-2-qwe.aldo@gmail.com>
References: <20261007212051.2574235-1-qwe.aldo@gmail.com>
 <20261007212051.2574235-2-qwe.aldo@gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you. I aligned the continuation line with the open parenthesis
and applied it to drm-misc-fixes.

z

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A334606A336
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RCM426wu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBAC010E467;
	Tue, 17 Nov 2026 05:14:14 +0000 (UTC)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9242410E3F1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 05:14:08 +0000 (UTC)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3ada4c06b7bso2282264a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794892448; x=1795497248;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7OpRTvgSnvnnwrod9+g+jHhPYG/U2Fp2w6j+MRb7R9U=;
 b=I3finI8B93VFHNu07Sh2xluiCOB12oahqkAtbpUFu78xiGjrfVYlbQLDx9q3fHEWI7
 QP8aEOQof//xsFxovmvmqNd3L54dz+jWLILAIyJcvD7/gsADP2q8FbSXeVw/S/GSExwz
 2ONwPJy+0UDz9I+jtpoyIpBm/8+WeI+jXUMSMr3o0EI/CS2oOUY2iEsg63nzbos24Mgd
 W+Y/2ZHnVUCpytlXlU3Oi4LSLyg2mR61Wret4ZSw42/t+HBKmwam+gG3JDVmvdl8wulP
 WTIesZ04ECyBuFU2Okn20S8B9tXRGae4Q5D8A/Kd6zeP+N5sa3ST4iPWb2kAcHruSa3+
 lIOA==
X-Gm-Message-State: APuU4Z8FK1UBj4IcdatOY+ol4jNYHO8HRAWaDTXewWO3mOg/HvfXTP1T
 0arKXs8PX6dFdjBliju1XINcRrnqifkda39jKWcBhf/gxmOAaUelCAj++4seI2d6LXvpzKOjsXd
 6gQrgnBFoiw8tcfehEa/aC3HJYg8KJwOfLObxpURHe0VDH5phN3gVZ9wCGdLCdECygYX84Yf2T0
 YS8Oym/RGf16ABjD4XAzU5K88SpzF5gUd60W/Kc/Pi3yLPcuESL3jGak9/9EWzgJmZKdKFd5itj
 6xxwlcPEJm707BbdxVS
X-Gm-Gg: AZFdTZfgoTKsFnrEJYX02QFnFNyRJC6HquEASyiznTPztkq2Iq53sZCIZ7AU2qsddez
 oHcSb4Gcg4FuFNbKZBkJsXMM5fg0PKLKoqzqJy8XnLeLPVmrq2f3OSWYdaNffCcy1jigZJpBT51
 p0U9vTj189tMvxMJqxdeOp8x/HOmCRaziQKYDhDDvHUwWnHr7eQ9lFrtnFjUSrYcG0i39Wwqt5p
 8gAy4J6Dt41y6KABAIKoMNS16t7pfEaEcsOzMMTYaTLO+S8tFXU8edfnWh0cAkIabXaxEh8EPj0
 AAAWlKoeK2jZwuO8R/tHNmuYmSjMEM93j9fYW0jbgYbgWhnEyWGo9al0XHEiVHFFY45/3kadwpT
 OknPdW7M4/0W8JgcTSUDL5vZWYlAdA88MTIJQSYN11xXTSeW0uKL/Dyo66OAsrxxP4zEPMy7hwW
 bZFM6fH6V5WAW1as+kwHmisdAnaQ/tRAk7
X-Received: by 2002:a17:90b:4a43:b0:3ac:9669:846e with SMTP id
 98e67ed59e1d1-3b1b0b4b1eamr10911197a91.27.1794892447544; 
 Mon, 16 Nov 2026 21:14:07 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b3abeca517sm1145445a91.8.2026.11.16.21.14.07
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 21:14:07 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cddc4bde4adso1986983a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794892446; x=1795497246;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7OpRTvgSnvnnwrod9+g+jHhPYG/U2Fp2w6j+MRb7R9U=;
 b=RCM426wuObG+67o0GJgmM2xuLrHJ+13QPS9cLHHSYuAM5fLxZyDkJCruRr4vXf5eqr
 MscC5vxwnagA3O6gow2cJ0dXhCAZcvI6bOjjSZluIZa2/6KLG4pHpOzLfijwoI+rA8Ma
 0HGHXUm0u33ZMNzGDGe6FFwRKusu0gEJV4CSI=
X-Received: by 2002:a17:90b:584b:b0:3ad:4bfc:1e77 with SMTP id
 98e67ed59e1d1-3b1b0ccee09mr11520914a91.66.1794892445686; 
 Mon, 16 Nov 2026 21:14:05 -0800 (PST)
X-Received: by 2002:a17:90b:584b:b0:3ad:4bfc:1e77 with SMTP id
 98e67ed59e1d1-3b1b0ccee09mr11520888a91.66.1794892445185; 
 Mon, 16 Nov 2026 21:14:05 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac4cff6fsm2085434a91.12.2026.11.16.21.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 21:14:01 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	maaz.mombasawala@broadcom.com
Subject: Re: [PATCH v2 2/2] drm/vmwgfx: close TOCTOU on guest_memory_bo in
 surface reference ioctl
Date: Tue, 17 Nov 2026 00:13:59 -0500
Message-ID: <179487959550.2515856.4846185175669582096@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007212051.2574235-3-qwe.aldo@gmail.com>
References: <20261007212051.2574235-1-qwe.aldo@gmail.com>
 <20261007212051.2574235-3-qwe.aldo@gmail.com>
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

Thank you. I added a Closes: tag for the Sashiko report and applied it
to drm-misc-fixes.

z

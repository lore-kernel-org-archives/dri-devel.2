Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8507CC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D3210E677;
	Mon,  7 Sep 2026 07:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TtW8cTgx";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CFFC10E0CC
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 22:25:27 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5b4a0e5aefeso2463084e87.3
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 15:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788647125; x=1789251925; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=up7v4iXfsfw0NZXjJnHOv6nLKWdrBroAhEtbXWzurTc=;
 b=TtW8cTgxX0ChAX/Gpc+v1/IPXZ6QlNkpH2WVd/qe6yjcvK++elcsKpS/a554d12sSt
 kp+9p2M2C2WdnmAh1scC4OURYjczlbJ/sgWuns7WEi4zZc5j1eyHBeAXBHpwpgOEdP0J
 P5hvlbxf8dbM2KVBxxlWZ46gUc/Ndi0lpwWr0AVI4B4LdVqHpK1PpBkTYBUYFzpcu3LH
 oTPj4/N+gGB6WBI4T35101otgLV3be9o3t+YdZms2UAwsuJD98KSdygP4CHWPJaIE9sh
 dXQF/zWT757imUmHbI49Etmd+VxuqTxxTKJ9S1cd9wZCyzLz4KWMQq2aLl2NTD5w7gKB
 ZAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788647125; x=1789251925;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=up7v4iXfsfw0NZXjJnHOv6nLKWdrBroAhEtbXWzurTc=;
 b=l5lJDyMWALn3NXQEhFUsKSgL/URhfErKeNn5skZR8GMMuGb1QnVLG6QhYV9703AB4M
 7YNOpU20XpAxrDdDg2/IkWoHwyo6lV0XJwnrizfovfIAm9aXtd9M/uTCVnE7kUsx+ulx
 mCkDHxm6rE/ef0YUFVtv7VdGm5gNU2ZLf/PB+ZQwDv5TJn3se+Yla24GVqPCmV5GxE5Z
 I0WiIQQKYrQczhJ2nLJItI1yBzE6w4PG6PcQujTe8NC8T9BOXIr4Tf1fjrPc+5jTJ8GD
 Wt6fOlQOXA6awTmsI0DoT/oHC9sHVO8p02stbyh25hK+hNKc0h+TfHIyGS+tB6+xMD2i
 G02Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOamwpZsjckvTI59cRMXSvnV5zJhtHzh18krLkHlljXjGxSrooxxXqsquZNHXf5hWH7Bl6zJYk3Xg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kLJ1JyOol/3UK3aEotfNiNTzo1v7SaQwuRaD85V1JDxE4vQ1r7
 tVJRs8c1eBSr4ao0feAA2d3nFR6GQOTu4eoEAfamkBr569/CZA6zCFsq
X-Gm-Gg: AYBFou0gKL0NlDHsW4GaJ/DsQKlr+UXVzpT2hyuxjrkffS68VGnewFrl5HDuBsjvYQa
 TIMzCPceBn8UzEvBfzicjva0fYnPKBS/B2diqnlTCxTMMNr+dgdxFGl50REi4R5S6k5VB34tabH
 tJT1bj4g6X//QuMZKO2zyT11RCDMDezTC1b4/DBuiGT5wL1uu3uh1+bkATdS1d4xxmv+85W68R6
 ceM7NtwEgw5hgT52A2+pZDJapAHXaPhvaqDEtdn6oIxvU6i1OcUIhrZ5p63KhWd4BnsZWK8k1zZ
 BU8718ptboYT+C/4Igk4mcw5RtYBAJBz1blC9uJ+JVvmGcLkyyC297ZJ8Dy0DLylhAmDx7OjAcU
 q7dYtagtWLwdZ7kyR2rPLWHaMBTbc/8HlpiDZCW2t/sXEWZAMv1LdXRxNT6f6Eq4sM6FLwLn1JW
 s6b1Mmu0xxYcq47fn293PmG/kEk7xyHD1qDZRsgWYXkiXcy6KppOdAr1SqvneJrCyMbF3XjRI72
 nLQ
X-Received: by 2002:a05:6512:3503:b0:5b5:e8d5:7fff with SMTP id
 2adb3069b0e04-5b616f0ba95mr2232510e87.8.1788647125226; 
 Sat, 05 Sep 2026 15:25:25 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu.
 [2001:678:a5c:1202:7b92:9ac1:b9ef:5287])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166f6c00sm1299495e87.35.2026.09.05.15.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 15:25:24 -0700 (PDT)
Date: Sun, 6 Sep 2026 00:25:24 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, 
 Felix.Kuehling@amd.com, Mukul Joshi <mukul.joshi@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Mark Brown <broonie@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 rust-for-linux@vger.kernel.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm/gem: Add callback for when handle count goes to 0
Message-ID: <apyTR-f8W6Jt7uP5@soda.int.kasm.eu>
References: <20260831183311.1090131-1-alexander.deucher@amd.com>
 <20260831183311.1090131-2-alexander.deucher@amd.com>
 <aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info>
 <e8a53eb241b2cc912e9cfad5f6a0120aa9683481.camel@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8a53eb241b2cc912e9cfad5f6a0120aa9683481.camel@mailbox.org>
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:00:30 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 2026-09-05 11:31:41 +0200, Manuel Ebner wrote:
> On Sat, 2026-09-05 at 07:36 +0200, Thorsten Leemhuis wrote:
> > On 8/31/26 20:33, Alex Deucher wrote:
> > > From: Mukul Joshi <mukul.joshi@amd.com>
> > > ...
> > ...
> > 
> > > > error[E0063]: missing field `handle_free` in initializer of `drm_gem_object_funcs`
> > > >    --> rust/kernel/drm/gem/mod.rs:265:58
> > > >     |
> > > > 265 |     const OBJECT_FUNCS: bindings::drm_gem_object_funcs = bindings::drm_gem_object_funcs {
> > > >     |                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `handle_free`
> > > > 
> > > > error: aborting due to 1 previous error
> > > > 
> > > > For more information about this error, try `rustc --explain E0063`.
> > > > make[2]: *** [rust/Makefile:799: rust/kernel.o] Error 1
> > > > make[1]: *** [/builddir/build/BUILD/kernel-7.3.0-build/kernel-next-20260904/linux-7.3.0-0.0.next.20260904.221.vanilla.fc43.aarch64/Makefile:1442: prepare] Error 2
> > > > make: *** [Makefile:256: __sub-make] Error 2
> > """
> > Full log:
> > https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-43-aarch64/10951622-next-next-all/builder-live.log.gz
> > 
> > Reverting this change and 2/3 from this set fixed the problem for me.

That leaves only the documentation without the feature so might as well
drop 3/3 too in that case?

Otherwise, the following also fixes it for me:

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index e1ebad77ebe2..847e0ee38863 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -278,6 +278,7 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, Ctx> {
         vm_ops: core::ptr::null_mut(),
         evict: None,
         rss: None,
+        handle_free: None,
     };
 
     /// Returns the `Device` that owns this GEM object.

> 
> Verified.
> 
> Thanks
>  Manuel
> > 
> > Ciao, Thorsten
> > > ...

Regards,
Klara Modin

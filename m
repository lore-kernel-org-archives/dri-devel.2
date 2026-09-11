Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BABC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75A010E9BB;
	Sun, 13 Sep 2026 20:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SbUpFiJU";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F0B710F6AD
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:07:14 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d71d1cc8b2so11810995ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789150034; x=1789754834; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FHiA3vP8aHPJSncILcJnFjkzWaRF94o8nGnqbNzUHNs=;
 b=SbUpFiJUGEYiLrQV1/DB8hNr7DUJ5tzzf6GppVcA7YB6PQXimrdFHok2vt3XrdClQ8
 K5s57CpDXQ13gRxCjQgq4pa+iwJoNLUa/PjZv1KRNVp+zZCrHJ3nKvuKqZ4sSGU40kbg
 f9stk4CgSarpARk4PFGMn1QzAZTd+ktYJ/M3+AmBn2ZRhtNT1dhje8Nj0nug4j2Lw1wY
 J6fybqU9a0sYOIHUs/EGQNnhWxnRBqAhJbxZ3E5MNfm7vnbYtTze24XDV/pwq2nALJ+b
 ZeLybdUnjtFH7JdATfcOLcXSYbkMGIGfay1zOH5K0mHZK1xceZRCDzHXzrE9menRKufe
 1muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789150034; x=1789754834;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FHiA3vP8aHPJSncILcJnFjkzWaRF94o8nGnqbNzUHNs=;
 b=TDSyUl7afSCsRpwFe2ub6NfL/V6iGOmgE+4KcVFPATslgOhhXeLcJS/XM70/fg6lI/
 7eORoQftB2VWQN7tnGyCs7NosaQxv3fsrsg0dcJMeu29mJFfzhG3mhHtrIq8pTBlx3I2
 5Um1gh8RJUFZnVrn3O9tIJby/h/Jv4O1imhhyM2RlRhmfXBy8ham6dCYXb2WZR2uElKl
 NKePVf7a0WL4akXvTe6mooFRBJXrLm6g16gC5kqlkm+kLa+MLg5HiC0cClf9TWYJS5EN
 cH6zi5XVAiRKt4c1FzeZ7fSjlTsZ7ko6isvP7nLN+xkKFVTVLTGreGG4Sr/bXDe2xK6/
 BuhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByNob47iej1bLeF1FDeV4c8eZ/etS28HUqd6v25vmufBm13QNRar3Q6a0/tarujd+V0mA4KS+dX8XA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mDTnXu9haCWtJ0+JARtafgpXKC9kgqrjU+d9c7wsFv3l2swmS7
 pgjxlpr/Rsgyi1KDLsIPFKfO1vUV5B9IHCq/7ws1ZzL0m80OLcUApnpQ
X-Gm-Gg: AYBFou3X0tdTjIZsqTs1e0FTd2V4/WmwA3v29kC/6RM5picM9WNQDGCF4rD1aN/le/F
 xYGoVI6Io0dNkrRYNL9wJ/zZqCOtJxzAE1vPuwFA5Glp8UJq21LBL2selhU5txqgoE9TB1JvyTj
 lTbXyqqYqpqT9YYJ9m0zTdlFgzKRe9brc9DFYEEORyMdaELiKWvrCTYLG5GN29K3LUYaJiPasGd
 Cg612yuBGxHd6amxlUTH9rrmLzsk2JGbnlSobsICWlSeWhuAqDT0z8xOF3qLQ6Jpp9Us9NJelD3
 BxeeCfwviYFZ0cjeqG2NSNuYJnmwBNASVazwztLHQ/KjpOjk28RsbcIwcU4VC/k8ujNMlZnrxWT
 8Lb5gU8lsj3snnsY7GkEteIl28plDwycZGSs/6yJxjtUTP9v2ZY3/fd3Oy0czd4q0kqduguew5j
 DI++DkYdsxEXFcpRWgpWFHogpfD7aUEfQtFc8zOXteDcPZ4WSrnmPY7kxl1F+ZZnR20KGmZLDkD
 rDM
X-Received: by 2002:a17:90b:1d50:b0:398:dcef:c040 with SMTP id
 98e67ed59e1d1-39d9c34a18dmr9599621a91.19.1789150033604; 
 Fri, 11 Sep 2026 11:07:13 -0700 (PDT)
Received: from [43.242.224.196] ([43.242.224.196])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e52a60sm7850453eec.6.2026.09.11.11.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 11:07:12 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ze Huang <ze.huang@oss.qualcomm.com>, linusw@kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/pl111: Advertise no pixel blending
Date: Fri, 11 Sep 2026 18:07:08 -0000
Message-ID: <178915002849.197282.4107045001044510370@gmail.com>
In-Reply-To: <2684f2f8-d349-4096-b005-b2d040d4cebd@suse.de>
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <2684f2f8-d349-4096-b005-b2d040d4cebd@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

Hi Thomas,

Sure, I tested Ze Huang's patch on the QEMU vexpress setup I used for the
format testing (master 7.3-rc2, vexpress a9 + CA9 DTB,
DRM_PL111/SII902X/panel-simple, panic_on_warn).

It compiles cleanly and works: the driver probes, finds the panel on the
coretile CLCD, registers ("Initialized pl111 on minor 0") and the boot
goes through all of device init without any splats.

One observation: with the alpha formats still in the tables,
registration prints the "[PLANE:35:plane-0] pixel format with alpha
exposed but blend mode not setup" message once (drm_warn, non-fatal
since 271e90eb converted the validation away from WARN). I also stacked
my format removal patch on top of the rework: it applies cleanly despite
the renames, and the combined boot is fully silent. So the two changes
are orthogonal and can merge in either order.

Tested-by: Roshan Kumar <roshaen09@gmail.com> # Ze Huang's patch, QEMU vexpre=
ss

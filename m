Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C134606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=c9KJMnIE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 092F610E67B;
	Fri, 30 Oct 2026 01:28:05 +0000 (UTC)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4164110E67B
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:27:59 +0000 (UTC)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-ccce6d9abfeso111367a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 18:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793323679; x=1793928479;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SPMwB1F63UMk/mqUERZdoM/TaXr/V0/rd4WtUg9tofs=;
 b=TNiBRwpPghCpNbrQq9WQdkb6uWQpSYUEiinEYz/hRSfHcqyu3lXhG4b6O6HijFRlv2
 U2L03sZs0IMorVrCfm4bJ2HYmp7PQnN4sael+Wq7A+OhuWBTo2GKqG5KOo+JI0G60Ezh
 pNBIf4aUTd4p4BdtQbo5+Hu7QEtrD5KwKUSlcrSssWrnnhQha0UoCVD6Dj7gg1E88/7T
 qfnqHwoz+fOWcKQvMzZs2yDWazQ7b8BzB+dd6ypuvb/IIxbo3G1nN6SrzMDbjvJxBVEI
 WiM+RO4a1B68m15IJ6fGradOLZnXHZw014dv1vkKR55RPKcm2F+m/fcMV56MoYJzQWZc
 alLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+FEmFsglCA0VL8Ap8qkOLYOZIWE+ztjpP69cNWJio1Cd34VuW+n0E7x6OvBecOgbJHOESGvyhES4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ/Qp9gpj//G5pAZnoXsqFLmF/33SJ7UTTELhVSzDHvqr6jN6HD
 U+VcGShS60vbmFTSDsPW1Uoq5Msuens/va4yaT9oFjaE4n50tZggqtwHe914L1zRXgwk4NYsuNm
 kl+sEzwnZr0mCxuAIE2wXV+HwK2ImTV/rMTU473vMmY4z7Cg7ONJxxJKgJx1bHJgrNQULYTOPpk
 fo+++NhdKvcJRArSoeqgasSILtqgOHire6RBe3zp8y+eBrl6naG+c6kD2Zv0iGFcJUyY+CGoqeF
 a/paXOFm7MFfdaMzUKIoIkvVEDq
X-Gm-Gg: AYBFou32WT6n4sf7m9o8lxlkuv3UU+ooVPuOSpWR/3OAgeBVBDkozdzu4MaRQqgsp4s
 A0t+FuFdDHXIpHp/LQSEFYNNem6uyJZHV+XlgUh25i+xLWKIhqnYEmn1ParInevQXjxGLByUAZG
 afe9NjSOfGmmEmdHjpdKIahi8WCZBHHXhosqOGW3C2lcBCYCraOpYeyofuvnVeF+c5SAF7Hgr/e
 s7CjcXG0RblZQWxTL1ERtINfprLCs5c/DCcOBD6YRcsdO6werdG/CJwjnpzaCtugF7qKnn5rd7P
 TSDmCu5COq5O27NrnLrc3/G6P0JUZmBGN+M8D6XjK4iKbalbku8owmaBWByViuGuxQWNZHWlPWv
 XTkSy44uAxESUJFouvZ8oDc1TQufqyv9l/FDdvltGw9wWur+kmkRCC9PAUxzaQy4QsTnxJ0ZLMX
 dNSfPEOPnxLEe1fNX4oFgb9TNLmiAIpDgRb0Ettp5+
X-Received: by 2002:a17:90b:2551:b0:3ac:a7ee:6770 with SMTP id
 98e67ed59e1d1-3ae895a5bd3mr627181a91.7.1793323678691; 
 Thu, 29 Oct 2026 18:27:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae845baad9sm950476a91.5.2026.10.29.18.27.58
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2026 18:27:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso522330eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 18:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793323677; x=1793928477;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SPMwB1F63UMk/mqUERZdoM/TaXr/V0/rd4WtUg9tofs=;
 b=c9KJMnIEb0rmzhGF/r04Mm2qam9NdQdXIJvME7jBezVLOEgI4GVWTdjlODY0wGfQy/
 b1ihBuIJhZtU7gDEGoEBpBX1wIFJtmTqROl2hiZ2q5/+xNSBLJBcQVTSybSuZVrzor+T
 oOhHX72tcabw8DJLPxrsW3PK0Z9xEfF9yDd+k=
X-Forwarded-Encrypted: i=1;
 AKwUvBxsEWZixn6d1Ojyw4lp7R2W243gQUTK4FTTvfQnanHmIU90u+uAexNtHaYzthecp1XEyYZNpgz5PyU=@lists.freedesktop.org
X-Received: by 2002:a05:7300:7b81:b0:351:7ec1:a92c with SMTP id
 5a478bee46e88-36a42431768mr2085836eec.28.1793323676845; 
 Thu, 29 Oct 2026 18:27:56 -0700 (PDT)
X-Received: by 2002:a05:7300:7b81:b0:351:7ec1:a92c with SMTP id
 5a478bee46e88-36a42431768mr2085784eec.28.1793323676007; 
 Thu, 29 Oct 2026 18:27:56 -0700 (PDT)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a426681aesm2786192eec.1.2026.10.29.18.27.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 18:27:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 18:29:16 -0700
Message-Id: <DMHS7SIDIUGJ.168385UCMC4QI@broadcom.com>
Cc: <linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
 <mripard@kernel.org>, <maarten.lankhorst@linux.intel.com>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
Subject: Re: [PATCH] drm/vmwgfx: Fix use-after-free race in vmw_dumb_create()
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Jayapal Ashwin Nair" <jayapalashwin.nair@amd.com>,
 <dri-devel@lists.freedesktop.org>, <zack.rusin@broadcom.com>
X-Mailer: aerc 0.17.0
References: <48e6780670395107cc9853bf63fa7ac1d034cdd7.1793249917.git.jayapalashwin.nair@amd.com>
In-Reply-To: <48e6780670395107cc9853bf63fa7ac1d034cdd7.1793249917.git.jayapalashwin.nair@amd.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

How is userspace able to see the gem handle to call DRM_IOCTL_GEM_CLOSE
on it before DRM_IOCTL_MODE_CREATE_DUMB has returned it?

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20


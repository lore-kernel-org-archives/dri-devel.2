Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C69CA5FE6
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE17310E59C;
	Sat,  3 Oct 2026 00:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="WIrLLMU6";
	dkim-atps=neutral
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com
 [74.125.224.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5019010E59C
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:33:26 +0000 (UTC)
Received: by mail-yx1-f97.google.com with SMTP id
 956f58d0204a3-676804a3a22so2955d50.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987605; x=1791592405;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lJrX9fLYt9M0fTdX5pauUjLPWBj7AcXVtE6UYAm986U=;
 b=NCRQkMCqvXULl6skAail9Fjp5QLMXym8eX+vZl61eZiagRt7HmUxl5ka91xZ4IJ/7t
 qVRzxAP7oEU06NhLA2Bn5LeEoNusTtkRPBzi6bvJZATfl/O8Hg82zR6h0JDnRRbgxLpl
 tAxjueQRJqAHJNoxK4zxU6dbJk4gcIhymX/F5SUWO1tRJkHaXzD7GpbhdKDthe813SiM
 UnljH2mewh+SFCvPIcp2NvZsvtXCZryFHuDt/+nBlWY+hkCRT+uz7XIitzWwyO5Xrs/5
 rwtb6Uq5lMs99PXUw4ug+ESxuIHn+vAyLiTIkPQ+jP1XEagdkUbHjV/Y+UlLmk4djcg3
 UP8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwww3xvbbdDBFtKwQQhexNYpWisKU/6Blz0lJkUZuhRh6vv4hy2XANuA8byqU7MkSShlYVzCoUMyi0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIbtF7RHuAaMGCcksvJ/MPGPvKuSKiNRkvoeTIfNZftTuq0kRk1
 tBjvRK5xyoPoEOaVrltUIUPWwbdiK+iBQfg2rBqPT+Ettm2OmYnv6VccgCnZSxW1PRbiPHCZ90J
 aMWx6PnnOO1SNGym1EBkbQUt0ujYeiZrxf1K0Ly0X4+VI1TLhUuGvzAMSAKK8SVnPhGSDQ/vyVq
 wQjekhBh9i/IsQRZWfzHdwsHQ7mIJZBKSCxYQlbtxrL+rS2FIGPGbYxpWZDdckxqwMb57TTFlGH
 6a4hEUlVuwsjmcEMWssgVBPgprj
X-Gm-Gg: AYBFou0nOpMLcWHhRsFg4fX7m4nu6cD7Sc661e/Iv+hnNX+wt7pvrEJ166wwcZlbkj4
 myE3H5MIldpfJCSOJIC4zgxHj/aMgPgs9XnRtbFBzhFsclUoGoH5N5sgzpgE9iGG/CW+9Ch4V6f
 BNrciqKpmoN+V9Ji1XQKr0cCJe5j5MG/ziQ1C0AcwG1Iun00Qlg1d33RAZCAN6IwaXF3KPn7kps
 Xmv+Hvgog1YDSK1Rpuf746y1CsDm+fpFN26snCNWm17wcBSK7qZa3ftoU0rhtWQr6mQ8w4YrKjn
 j/4CWlfQW/4dIKNsY7qMsOtCguatWp+3S6nEr8dRnRy080hKQy6niZjrth/vA8BpsD4mV1PeGi3
 9uOlQYYleTEiNzWy5/4pL4Z6WAyuXDBb/oc7Rh0Md2rC9N8YapVghTTLpbFDmMfctF/bkXlUG4J
 D71dyMrqemYWir4CWFWQt6ufIf51UjP88stq8GI3CsZWg=
X-Received: by 2002:a05:690e:1182:b0:677:b096:dcbf with SMTP id
 956f58d0204a3-677b096e271mr1391342d50.50.1790987604639; 
 Fri, 02 Oct 2026 17:33:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-677c1bd7c26sm57893d50.34.2026.10.02.17.33.24
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Oct 2026 17:33:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34ef5fd7934so204566eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790987603; x=1791592403;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lJrX9fLYt9M0fTdX5pauUjLPWBj7AcXVtE6UYAm986U=;
 b=WIrLLMU6F6X0Fp1DSNSkDmkCVXgaHvol9xApUtf9xDhHt25DP/+DeN1l2eVO3k7bSt
 7IEIdU2TEFCjeJM4J58InEh86YcozBiSs9p9MO0OTv8CfYLEJEV9cJLCX7l8R12qGG3/
 KJIZQOU53HYYiFB420cVX7qSeoEx1g5FIstVU=
X-Forwarded-Encrypted: i=1;
 AKwUvBwFQqfRz7M4s1TWfWTK1urWkhqe9G1vCDEIZUCLr4zv8yj6rvSBp3QpqCX2YZb3vfszgE7xwKJ4Fxc=@lists.freedesktop.org
X-Received: by 2002:a05:693c:8810:20b0:351:165a:baec with SMTP id
 5a478bee46e88-351165abed5mr171030eec.37.1790987603188; 
 Fri, 02 Oct 2026 17:33:23 -0700 (PDT)
X-Received: by 2002:a05:693c:8810:20b0:351:165a:baec with SMTP id
 5a478bee46e88-351165abed5mr171004eec.37.1790987602572; 
 Fri, 02 Oct 2026 17:33:22 -0700 (PDT)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f15001196sm8595075eec.27.2026.10.02.17.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 17:33:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 17:34:23 -0700
Message-Id: <DLUS51Y9OLMS.UQR4UY71TFUP@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>,
 <dri-devel@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: do not hand the embedded sg_table to the
 PRIME core
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Aldo Ariel" <qwe.aldo@gmail.com>, <zack.rusin@broadcom.com>
X-Mailer: aerc 0.17.0
References: <CABQX2QMUUf1ETuLmvrzQ9_rsX4+KG32YAQJ-9hV3uakAyPiYrg@mail.gmail.com>
 <CAP48HfviFZXacVY9Lj4Hv7+brObhmxWLYAM8MNiTUkJNchnp1Q@mail.gmail.com>
In-Reply-To: <CAP48HfviFZXacVY9Lj4Hv7+brObhmxWLYAM8MNiTUkJNchnp1Q@mail.gmail.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Hi Aldo,
Using your POC, I am not able to recreate this bug you described in your co=
mmit.
This is on a top of tree drm-misc-fixes kernel with kasan enabled.
Are you sure the bug you describe is not fixed on drm-misc-fixes already?

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20


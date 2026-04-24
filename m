Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E366FED3D7
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 16:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D3810E076;
	Fri, 24 Apr 2026 16:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fVpNdhV6";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6958410E076
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 16:16:29 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12c7212836bso3699569c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777047389; cv=none;
 d=google.com; s=arc-20240605;
 b=SQlt/oBRuro0l1KaZHgDy10QFu9RGpIefEF7EjybhnVTcE91IRs/NgK3p3a98N4vN/
 4R2Egf69p6GdBFVHpnXAVmVCfIGgI3eXzQlqJO1RCCGpz4yTTXopUM5xbe6jN9I3NSY8
 EieokCH7AB4977mlp42jDzErfekzwg7t48uBpgNddlTJcx7XC8DJQG9sjbbbu/mtjFl0
 q4KhUcOheKjuvmpdsUlGyZfmu2u9Ok9blnccuZJdeTMaf+0LEX7AnCY0uHqgzyNytaSJ
 oTO5h/d22U2K7RZEmnUo36G0OjD5NxkjQKoCUmVwdM9jNgcRb4jYtcofkKNrXcUPBmhw
 /Qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+kaxdmfqBq8C2utWlphEm5LcRzpCJfnzuzdOC3D6RHM=;
 fh=+JOtogZilSoO+h9fUcB6wibF0R2d5L/4bBfKfV/dp7I=;
 b=TERjpCO3boAE7CYQOB/K40qmF/jp4sHx2eAwJVRHatQMO5tsema19TQXWwXeP4g0sq
 Qt/PR80IYTntS9Lxwn3pJfvQw1zEUNrDyk+xI1Y2LfASTFudu3oVoeEZyB8CR9+NJU74
 kEWIXBwyuvpkI/PxvDSi6GkvUnNrbrMy1vIBEwYvRSWv5fjTnBBq/+UhIXY0qnXeYHGY
 2RK0mUklyw1PD+eI9p89KwfD8K2scukhcd4s8rx2F8lrUDeWtM8P1Smprplqe5gQe82/
 +09VzIZJOcrwUg5JK1Qit38RyJX0Y00f7Jdg60yUqtMKKmO86230mtZTs31hOQc1G//B
 gfzA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777047389; x=1777652189; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kaxdmfqBq8C2utWlphEm5LcRzpCJfnzuzdOC3D6RHM=;
 b=fVpNdhV6Gy9WZs8C4zGb+/2VPMDjW7Qok0iBm7/HdKCplm5hlldNaKvvra66+QRG1r
 XZ54qNSAplKcX9gOXnbLQnaNO6zJU3stqlnz2p03YS/3I05pCXS3cm7F1/uXmCUnj8P7
 JK1PSd1IKer0ahvJ0ryAc4dYgff99DjfWKzaWl5CVI/5NlhkHg1utx68CpuUorQNd/Id
 zwsu3a/OWEKwe9y9gwEhipSm5sGHy0vgdRcbxk22FIf8goh4CHW1lw4eY6wxvkny/1B2
 lYNzZySDciSCGnxVlfSZtGeh8Ec/Z1v1XVk/nihUTQzABy8mkUFOGJQshXSkBmp4cYM0
 2yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777047389; x=1777652189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kaxdmfqBq8C2utWlphEm5LcRzpCJfnzuzdOC3D6RHM=;
 b=cSopOCNY8oC/9NAIWG1q7oJWTdPnuU0GjfWreBlS2V67AL1YLP/Oy4kjAlVY+K9tCZ
 mr4Bzn7v1xVFkkI0DPHOGSPtNYD84fLJX9NCK74DDyu+RbJDhEKavt71iFy56qXvgZ5B
 8LAkiG3QlLCu5boFhYoOErCM/BnwulL5D1Hz0ieuWEIPWFfyC6fwp8GNcYLgcO/D3xKH
 TuDGhQqDIH31Y9MUb0L/A3ma5O4cWZFjIlRSgq29x69qaNSf0/uf//lPF53laYNC1A+h
 dgzSf+8O7INiGRE6M9Gce8XVW8ImxfqHDtCYiLsZx2iMjrBiH7KuPIEC4kc4+OZM5zzc
 8qnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Q+LJw4Ody80pJ6VeTrJ5Gn+IXGsF40Luzc2/yRzVrNdM02SnfcH1Pisp8BAKAO9WujnjhCtUOh+M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyH+hlR1g3RHzFYbRBeEcRm3eBy4RUubHh/Ji3dv063aqT28Mny
 gmCPod/2faWLWjzomI51u6XEPY1eAZvErd8igFOfR+jYsv4qTqOARcNgbv0Qi2YB5lBp5q/0er/
 CD6iy+7DCGlKSzTKb2yGr+TTdpureLy8=
X-Gm-Gg: AeBDietJzPG33kZwIedJU80O3a+uRNsFPXZpwxbz3Gude9fCiJj3ds/R36SzAq8QUGy
 FD79ENyEDnD5UoBrwP3AgdHJTVmuADnCvvaF/pOWqNyyZm43qdB+qO4gRBsICQcimKutxgyHkep
 JCLwz9kE0TdhQGN2/mM2e/eHP2KkV9VtBr3ZAH41bT0uGyy0cSjNAbBPfLisDZGQ9ZJfIQhfaN8
 XzLXP40SpqU+3R0/9fKA4iXflm2ZCMaAjW4B4EGbMQIkJV/NPEozWMjOXxHIOboorOzFi+b9s+v
 1chBCgLhwtnIcM8qrWk8/+T2mt9U1RY1VbOgKnfy6qIEoPMR2NsoE8UBOd/4CJu4Nl80T3J9xb5
 tAVefkzM69/NE8VmEK7U6yMfm0JYZ5/7zo5lbGA==
X-Received: by 2002:a05:7022:f016:b0:128:d4be:7438 with SMTP id
 a92af1059eb24-12c73fad42amr16965861c88.30.1777047388527; Fri, 24 Apr 2026
 09:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
 <20260420-beagley-ai-display-v1-15-f628543dfd14@ideasonboard.com>
In-Reply-To: <20260420-beagley-ai-display-v1-15-f628543dfd14@ideasonboard.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 24 Apr 2026 11:16:01 -0500
X-Gm-Features: AQROBzA6ToQMdPNxQfm-1s1rL8nfgq-Z1E4rbqFRJtKj9KT9hbDXQ7tUBkUOYMM
Message-ID: <CAOCHtYjJgqomKreDxLUiVbUtpeh36f0bL-jA6P-6rsoJrweshQ@mail.gmail.com>
Subject: Re: [PATCH 15/15] arm64: dts: ti: beagley-ai: Enable HDMI display and
 audio
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Lee Jones <lee@kernel.org>, Aradhya Bhatia <aradhya.bhatia@linux.dev>,
 Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Andrew Davis <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Apr 20, 2026 at 8:04=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> From: Andrew Davis <afd@ti.com>
>
> Enable HDMI support for BeagleY-AI platform. The display controller used =
is
> TIDSS and the HDMI bridge used is IT66122.
>
> Based on DT by: Robert Nelson <robertcnelson@gmail.com>
> Signed-off-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
> [tomi.valkeinen: cosmetic fixes]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Tested-by: Robert Nelson <robertcnelson@gmail.com>

Thank you for getting the display back end working on j722s family!

After this goes in, I need to submit the usb/usb-hub changes to enable
USB support...

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

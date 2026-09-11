Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B393C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B8010F537;
	Fri, 11 Sep 2026 07:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SJ6RaHqj";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5353D10F1FC
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 00:17:48 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e50968489so238827d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 17:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789085867; cv=none;
 d=google.com; s=arc-20260327;
 b=W7+Jep4rrqo3kcMz/Zxq1goPk8cr0EXpp3XwmS6ALa0SBAPRrFjWRkDOv4q9d6whf7
 NmiWXbhygJbWr8NSFqB/pljVYsUyvI6UWuEzAWXzqrihHX99OM8KaSRPhEy0zDOTng0r
 IiYF11+00XV8imTuHd0irdDM8AVZ0Nfd4YDMZ+KgZKcULERXo5Sj9YszRrcbJTauvmUN
 iyT8t6pjEuC4tVChZyfC0/kZcSWXjGtxBbZeCJA1gVjgMY8XaA2wQQ85sgMvxJ0iVfXo
 Z52z1NPb+xy1NXSz9Lau3yxhaIMG1tIPHLvVWJfM4KSRNvQHAhvRLeGvIZasjldk9dMH
 ZVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n9SrHN+fgpLIqi8Itt/3HtMz4SuMQlkWH/sPrxujiQE=;
 fh=RoBQtXuIRYeaSCs0EULYrrd/NPttZaa2SbqEvqZCMvo=;
 b=O5MhOB7VQGEfbSFyt/anyK7KK6l5TS0iMCOXpUTMYRHYshRUzPAHEHzz324MNUDuma
 /fcMHXcNyh9BIW2cYSLga2GZWUTkYzj6xRENd4H5xzvu0s473Y9VpfoW4b+MHSd5AOk4
 p89D+hYy7gaPbhC0RlUtCEhBqa9IVOsP/urO8ClAdWL5aM8b1DsBibULOAB5iTVrx+5/
 rSGWwhqC7OEDJ570YHVQt3qUL2ASdD/eZuzocUd8SW0UPmX/jm/VpspjWu8kYBdEDxSO
 tGbVKgSpirDnrWMUcxiQorJrI8ZdEMtAbnIY455g61O9sfVyq9eaxQ5vvkayDknD2kkM
 MdBA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789085867; x=1789690667; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n9SrHN+fgpLIqi8Itt/3HtMz4SuMQlkWH/sPrxujiQE=;
 b=SJ6RaHqjwJD0TIVSGruHyfeJwsMf2cnF/ri3glhGeOEnjepFJIlrxjDbrmFIuPjwCY
 B38hC6bBy4XpRaYCTB0hDZvUTy5qr1vOnvQ1X3NcQhb3D5aqUs13gRU/g/RMRORh2RJD
 2MbkFntRiJoxY+Le5hikDc1Pm2fLl5+FTjUOYEpBeoPwvWKv7P/JP02BeGZuKXZPdLrC
 DxmoepKkc1VeK5SiVd1j0pbHKHRsV/e7Ux9+ALJ/3CWCDhE5fsCTG7rShJGAJwuAuhon
 Kt38lxwD1Ryjvsg2vfIJR3lOPCMtyWm+U45kvHAw8dng1wjNdOjacGl8wvHVbFFn1/7Y
 sHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789085867; x=1789690667;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n9SrHN+fgpLIqi8Itt/3HtMz4SuMQlkWH/sPrxujiQE=;
 b=q+eFMguYF1wOwDDeu/JwKk01GE1tyeoE+ttBclNWa8M0yQw0rc3cnkrqqiIuWKBORR
 37K+knba5QKGF7tJ3XDUX2UBNbuLx4OEn1fGh/j0d9v8+XptGnRGw6PE5mFHMaXxprgo
 yMK4sA23FW39lOcZe+sPNQ+kyFpaVtwUhZG2M+ehYMAoP1UJNZdqbnsnzesyIRlm1Gi8
 c/t92uUDQRh2wEEb9izY4Gi1iBPZNnN/LE9WAfhpbYTS0H0mJD/ZUCrsNZ/CZwH4wANg
 ILOpzyR/PhnJno0c7xQky7syCESEXKVrnq5MetrqgzeMajxCh/nmJ9fz93VMIno7b48H
 wtcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzschke5nINGunLQy1PWtxdKn4vbpDJilUO86XlVxosScrKc8CuqNUlewK+wdclpmNY2XnMikmK4vI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nGNtJGNOJghG3unzxI5Zs1QZgNI1bJ2gRmF8eBShoZh2SWZDuS
 icV4mOHaKP3mW1lOJjc2bklbGFcL2QUMj/SbiQEByBJGzZFj3dHTRufnI1HEnwERe67Shf5jKy2
 CCvyCL9q3XVh+pcxmTHUi9WLoFZkUMv8=
X-Gm-Gg: AYBFou3yRM3dFXOEGq17PIQyZ2paU87jBiu57SnVb4Z9JFxA1Qij6Enwa25QHKnYn35
 MUrgrtCrqVHZKBvpzTvj0cKj/Zt2+XteUIHx/QhFvgQZ1lqKrQwCnD+IAleoQK40fQ/go/siq2a
 Qh2fiWh/E4E2HJ0Lq7XjKFrsH5/pYikbCVRW1QlF6XGIGRKrGrghMg2EToVQg8rGwzQAC+iuG/z
 3lHCK5S8CszhjD8URiAtmm8ue0iWhCNWTyXEISUnSpoBZ48jKb3xv2Vs1h6MBw1MeN0pua1UCDe
 e+m7q45stLOxzauW9SEm58TKfOhwbQazuAKmvAAcCCE6dMW29cF2eJYZWVNLMSZaqQx6FVrgUhU
 udZDXaquCvO3qIHkJqVKZ0P577eyuCwDIoXAv4k2B4TOCB4n4SBP91GYZ6WtDxeoMVSgoDf6382
 1zinRLJ+CjpkumO9eFn9TaHR1XPkUiFJHoHyVn42rUDrVP1ECFYNrHrg==
X-Received: by 2002:a05:690e:4501:20b0:671:1feb:199f with SMTP id
 956f58d0204a3-6712473278dmr616377d50.45.1789085866400; Thu, 10 Sep 2026
 17:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
 <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
 <a8cb0e4f-a2fd-4478-99d6-fdb043a9d15c@gmx.de>
In-Reply-To: <a8cb0e4f-a2fd-4478-99d6-fdb043a9d15c@gmx.de>
From: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>
Date: Fri, 11 Sep 2026 10:17:29 +1000
X-Gm-Features: AcwNN1Vors9QLM8_x5o0_B2FetldnvezlCJ6C1fncIRSIhuR9h5MtKq7gbNFw8c
Message-ID: <CAN5rfbQaXnYJszenqQvP3i9TSE500UJTgTQZUtQVxmRsqwQN9A@mail.gmail.com>
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Helge Deller <deller@gmx.de>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Linmao Li <lilinmao@kylinos.cn>, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

On Fri, 11 Sept 2026 at 06:39, Helge Deller <deller@gmx.de> wrote:
> But I added a
> Tested-by: Miro Krop=C3=A1=C4=8Dek <miro.kropacek@gmail.com>
> tag, if that's Ok for you, Miro?
No problem.

--=20
http://mikro.atari.org

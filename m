Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365B3E9381F
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 05:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E98E89317;
	Mon, 13 Apr 2026 05:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K6aZHVeG";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DEE210E028
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 05:59:30 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-671a2f4fd28so142630a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 22:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776059969; cv=none;
 d=google.com; s=arc-20240605;
 b=LvBSFyxGrVM2R7/d+j6u/dwffUpTeXouIFeTVga0BO5U2MZV9whJtIebJMgQIPJt6w
 PpsGLNyJypB/xqkCuLKZOYp9S94EtnYkpr6ZSFa21vRiWd2jkgulOExoANtbp0DKzqNJ
 +r6Xloh21CHA0BwD7anp/ezQWaPWeK9BV7UWASO5tPzgMp1oe982c83AC2tvbvEDMfzM
 k7qcTXc5pOuNne0MSpkiqzsirrTffAQIr+VINIgQKTw9p8kW0uVxQDQUTHW8g/tgUVmv
 OBHWqj2UD39AHfjB6ykUErqX4PY8Am44NiYEbhr6BmcBbzsi+F7hRY/AJU8MUpk1VfCO
 jDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qNEpgoGKCBmpBW7B8Pk3rg81p9M1LG8cQpxkmfpgVi0=;
 fh=Tdz/HXEqSYFOqb+XCywEA728/8bZDsc5/hKoJtnYNuU=;
 b=KyyRBCEbVLkOExzo3MsMBP2QFJz9PbBDOD73eJtNdTSxR5MvFzRr1FYRsoh4JEsMZz
 r33peJ9KQQ/EGDeV6SXkNM02fFX+aJMuBW4W3+zc7mJVveieJkDKkl/SxsQww7PrpUjG
 dlI5b1Qwmn81k6dA9fJ1SWr54uZ5GWQJTUDLNg7O2aMvnfdnGlDeFTF8FutyG0FVwYkD
 ZxIiBi/TGBOuOrye83YEfzzhiLRr34FX2JkDin3Q6eUte5vzTn/GNF9dO/ZvXuRGloMr
 SQhJlcbnIOlNRl1asxydLqan5EBWcUhhli+4dK6fnRLNOeP5sVgptqaM4jba0Q6kma82
 W/Iw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776059969; x=1776664769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qNEpgoGKCBmpBW7B8Pk3rg81p9M1LG8cQpxkmfpgVi0=;
 b=K6aZHVeGqseKcMqt7yLR6Yc/iijsJ/kOEEHZEGLg4QGjAMu+jpuAyR1qhUuxRQpOex
 YekeuK3n1dBwJqpf3Ymb5aQwHzNO+iaOxMhfYZbVoJh7dnfcWungbWLPsE1FyJS4jI/u
 hG08VtdLANXS6ZBSfQ9PujDDeIrG1kTiz4gWKNA5dK2eXcJtIhqNhEiUL7UGOkXGYS8O
 CMtafjpVriumUFvTzkDSR3LaQR4MeORkUBSJyEwsKHFLKScU4Dg4jX5+yQpyYYrnRZzV
 OpIT1XrLER+IBiaZ9Bjw9mrMIGyv1mWkOxIpVdsHysxGSEEC9g9SfdDGGb6S9foROeV6
 NnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776059969; x=1776664769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qNEpgoGKCBmpBW7B8Pk3rg81p9M1LG8cQpxkmfpgVi0=;
 b=WxhzImwGEeJzgWrHkGe2dQW1gyFAAgt7Gf9PfTaNYK98S7W5UmUNnNxpRqRIQ4ZfIB
 9iczGFZB0l0ZVXBo6HGU0NMPjkmW2JGumy97JdLmGLJ0StzbUPv1rk6G4QlIN+LRRmYj
 83nwJCxu8/53urjh+6F6/7Ri5JYprj/wrhrFHcYYAmihbFnTBILUDclU60kGR0ckJk8o
 LZzKa+1BL7toOKsNLbKx4bPWC6lGZ2psHeFO7qc7Z/0FUjrEp2y+vUTFeis6gddPM+Jv
 qwo+jr+x4q9hLJ0efDOCFnYnueP/hs9JyW8O3FhR5fbBVbFaiIoT13dxXHnWnU6jQ8XB
 Y6yQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EqvP2IC4WO6J4sLN1j6JGunv0gZgOvN55/3EnJG1CWUFJfq+P6KI9En7KO51aOuqyTwPdOrINU1Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEAoKRI24Cwq5VDZug9MFRUYgJSllLL6H7i7EXMB83l5+q6/2R
 ASO9hsW9XuC+6SGa0iamUjKlVM5+O1Lm2gILPB9jruZ+djl8bsdDZL1EebQWZ4qXTjnGpYu/jSQ
 vf24dTs/r4af8kwTAG+4FtEPRAQu2/0g=
X-Gm-Gg: AeBDietlMoVs9b3fkgqmc9bVTlvfh9B/oNHFAMMLwETMk+h02sOxpSf+hkL/5o0siSe
 NSb8zjVBKb5T/Xt4Rme155g4cPQPtsIP5XSIvXIrGghcxOE9kdWJX2CMf2sjk1U30gl+MFuc7X2
 7OvRev0yvJ8fQq7iLaia//mxV0YJu4iwySPSCCEOAB9Vw6msl+iyXuI3rme0K+PUbAHGlafUc5J
 Un3MX9buI5qGKx6yInsLZxRHwQwOgwO+lP2DkafvqD4JPOQpvjxsLsshj45NVz6Cv4eGlx3xk/Y
 J51n1LSEnTH0qT+K6Ik1icdHzeTVFGEfvBzf3dB8++htmJTLML6qVytoPtqJFdWufelW2ZP6oIk
 C6LdtdDg=
X-Received: by 2002:a17:907:788:b0:b9d:3af6:bd6c with SMTP id
 a640c23a62f3a-b9d729694cemr651556866b.25.1776059968313; Sun, 12 Apr 2026
 22:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260412173317.3329-1-mzndmzn@gmail.com>
 <20260412173317.3329-2-mzndmzn@gmail.com>
In-Reply-To: <20260412173317.3329-2-mzndmzn@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 08:58:50 +0300
X-Gm-Features: AQROBzA8j3VszXwFcoXm3tMq33VS0vxR7xxrNxJqDXOQmJwlb3mUiGiFtaQEOGM
Message-ID: <CAHp75VcdWMvvM-oKTqRACSXSUiVsEh1Ep_82MsJxfbrG4thUdA@mail.gmail.com>
Subject: Re: [PATCH v3] staging: fbtft: replace empty macro args with identity
 converter
To: Baker <mzndmzn@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Sun, Apr 12, 2026 at 8:33=E2=80=AFPM Baker <mzndmzn@gmail.com> wrote:
>
> The define_fbtft_write_reg macro calls 'modifier' as a function.
> Passing an empty token as modifier is undefined behavior in C for
> fixed-arity macros. Introduce fbtft_no_conv() as an identity
> function to replace the empty args in the no-conversion cases.

This trick is used in the kernel (usually for u8). If you really want
to improve, use _Generic() instead.

--=20
With Best Regards,
Andy Shevchenko

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A72CC982DC
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD8FA10E709;
	Fri, 18 Sep 2026 11:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="r2CEMeWo";
	dkim-atps=neutral
Received: from mail-qk2-f24.google.com (mail-qk2-f24.google.com
 [74.125.230.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A49EF10E709
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 11:25:04 +0000 (UTC)
Received: by mail-qk2-f24.google.com with SMTP id
 af79cd13be357-939695b5741so58106385a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 04:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789730703; cv=none;
 d=google.com; s=arc-20260327;
 b=YU88yKux/IdqIbMQJ9vtqrw2anG76ejH0M9hdcW3YHxUwSdTeFcv1zatGdd9HKCdmj
 w8z28eQL3vz53YVOi6SujvzbG2ROyBZU38wTyjvHQPY3cYHzXLGOAx907kYPOGbbnOvq
 6vsGoAVji7paRPrz7nOhfXDmberx7s2eE72BB/idE3vmifpJyM83xRoK7pK3l7Hu2gSN
 81tfxhwAYQxSdjnA522UmLR6mkrVo8/9EX69OilSKFkSCSX0UzA8JqfTm0hO0O6OzYRh
 Cq5ZMqccI5YXlQAemQdGeSCdI1NPC8FeWpNCTJOtN7Qh1Pvubq+5DWQklEzYbdKrpxzn
 m6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fxNae09A1OnN2DhU/tJerCjit10PKrqeq902N6O9xkU=;
 fh=/cIqTdJBl0sXalAFKtBoHcehYLKKeuPYGJ9PeLhrhDE=;
 b=DT2s7BpB3S6WJdSrPnhqraec+KiPBmwqGvR+LILnVAOjfF8lPFA8ggVmhgTzNlvKq7
 PEaLIHAti170uaWKhJTRKaJQSSGRPANVFMLs9pqQcFJMl5fj0IRgNsN3dsTZPy6dLunc
 7RznJahx4PKsMRk/ktvWekCGSeihKyNnS2hsrcz5vrDXZX+JL7qWqq/XbQNMRuuJa6ZZ
 u239Ii4/6tL+x212Cb2gDZ7i1C/C7SBYwXjm71lwlmuVNl4D6m4Lu5id8o3ccm2G79iD
 SHU6YH/l+lZKdDg9hYfbYrDeMMr/boeBqSByFQRlJHfEStSZ5BjTULVmymTiGADFez8W
 VsEA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1789730703;
 x=1790335503; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fxNae09A1OnN2DhU/tJerCjit10PKrqeq902N6O9xkU=;
 b=r2CEMeWo9Wj5va5rJXLCIL+HeEYkOR1OIINwXNm91+Pms38Y7eNmJse0VSGY7XuQdm
 Yd0pKtMKJ4kNOlgBZagefvfXfXj6KpaBHoieYB/Uxe5fCPOFGyftYiSmA/e7k/t//u//
 9sCIlpIGZibwZP3rLluVV+zrsAhdvlZhciE/wZ5tvKZ2+mhXAceNnO9NESptnef7aIW5
 F2mtG98j7q6Njcw59EHBa0zmw6oKdJCdh9lMKsFNUUgABJO0DJJbkMmEH2HEmTqmTZ+b
 0qN/ZL8SnqOQ/Z0h1vZBvFhU7HeJi6wzAYi8av45CGsPbY+s/SiUK6w7RohUzySECHoF
 Pdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789730703; x=1790335503;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fxNae09A1OnN2DhU/tJerCjit10PKrqeq902N6O9xkU=;
 b=aYzS2E+kmnm1KFDynrWCJIu+8IjTZxdbZdXR6nAZjuBvmBZNAoNa0YVtvwBqwYua7n
 sZNHzvEV5GPX+rqOgUCQ3jonhhSuzJOi1gbJHwYAxiF7+w32uL/5eOOQHAg23O0CEpid
 VhxBKarwpqhh5mB3f9rUwJL/4Svca+A2lGOc3GYziLYg5f6SfrAqeVXGVoNNSXmB2lqX
 mjbH9FVMxpG+4mP82mIk8WGAEHPIPef3Qf5YTlJErYNR75hQAwgEAVKN4nrWD/gppTiR
 znb1jJV6pa82bsxTfhbaQI8uMfn1mCptYuD/f4ha+5JfotsO1F1qxNw800Rp8eRNKsg7
 Tnwg==
X-Forwarded-Encrypted: i=1;
 AKwUvByUW9Wcfvc4u9jfgyJdf2c9QysZ8NNwrGIodUZDCPp/AdgX6eFkfT01P2AW9xuhvz4rmgkzI1IIjxY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nQAQp+0tQt/aFPKQZKgIyO/nxh/k9rXBIqAUkIIAx/BGM6f0Te
 Kk8euEf84aP3rum2sQU8o+aw5cDoe9DhnG9vsIEA+WKAT8JMZRLyeF4xvdtNKrnLoON0W0Rmnmr
 WIhxK9/nLRErlYgRfDgu0OcUbXIWXquE/ACHPIN9P2Q==
X-Gm-Gg: AYBFou050DpDJ/7mLi3jPvGIM17sjLqrzZhnw2e0uSNkfa+ixHu5Jr5woflaKVUOXf1
 B88Ma+p0H02yScz0Ti31hUysLhk4bnnnbpgxqvjKiydKo4vTOXKyKhbSwmyL1qp3TIL/Fe64hKd
 GUP//7y4rMY8s6JZTbz1DNFGkCzNJkeiq6K0cmeaGZwO4iwj5kFujoPPUZ8gKei71FoLSUNJI9G
 vH27NjNtC2FU4C2aBH8H2wZ3A8LvhW5lOrU5oUUjTWTHe4e6ZziZGkgIhRbEE0Y23Xn4YupqYk2
 60bLq1yQakmeg6OUPit4DRWBvVfz0wfzmzh8DtrheFj+hgzaiwyTFuokCyLhp2fOfA==
X-Received: by 2002:a05:620a:6288:b0:93a:14c:3296 with SMTP id
 af79cd13be357-93bdc64eb85mr265730785a.15.1789730703288; Fri, 18 Sep 2026
 04:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260904130858.27803-1-royalnet026@gmail.com>
 <20260918100543.23974-1-royalnet026@gmail.com>
In-Reply-To: <20260918100543.23974-1-royalnet026@gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 18 Sep 2026 13:24:51 +0200
X-Gm-Features: AcwNN1UuXA_zYpic264Z4jBxnVkM0kgrR6zKknS_YOh0Jo6_SD-EuICl1_jx1Us
Message-ID: <CAPsqS2QXQda2ftbEJb_-Qeva9ay4+4ysdpUtj8jAvbyAsYiAJw@mail.gmail.com>
Subject: Re: [PATCH 0/7] accel/rocket: DVFS for the RK3588 NPU
To: Igor Paunovic <royalnet026@gmail.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, 
 Nicolas Dufresne <nicolas@ndufresne.ca>, Jonas Karlman <jonas@kwiboo.se>,
 dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Sep 18, 2026 at 12:06=E2=80=AFPM Igor Paunovic <royalnet026@gmail.c=
om> wrote:
>
> Hi Tomeu,
>
> A gentle ping on this series, two weeks on.
>
> Conor acked 2/7, and Nicolas's review of 3/7 means a v2 is due.
> Sashiko could not apply the series, for the reason you gave Jiaxing
> on 31 August: its prerequisite, the slot-search fix (link below),
> is not part of it. With that fix first, the series still applies to
> today's drm-misc-next without conflicts (git am only, no build).
>
> I can send v2 with the fix bundled in, so Sashiko can review it,
> or wait for your comments first, whichever you prefer.

Hi Igor,

Please resend with the fix bundled in so you get a Sashiko review.

Thanks,

Tomeu

> An LLM helped me draft this mail.
>
> Thanks,
> Igor
>
> https://lore.kernel.org/r/20260904125936.26234-1-royalnet026@gmail.com

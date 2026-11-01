Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F7606A326
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RcPFopmw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D15710E4F3;
	Sun,  1 Nov 2026 23:16:21 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8520810E4F3
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:16:15 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6ae14cdc63aso7512a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 15:16:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793574974; cv=none;
 d=google.com; s=arc-20260327;
 b=eE8T4TORG9la4DiZadN3/jhBNw9z0p4cbwUXDXzB0MJs6osSQSf9lWIxu5NKKln79Y
 slMEDgGPUNrCJsU9A3QsV8EW6Njdo8KNpELrfJutP140CC7h8LGlTvDsDh5Wx9BP/Tic
 UcPi9zWabgSkhVOvHIjBJdZdVlu2Kaclx40hHJKKkqja2eLb9P/Vzig6FDQIQSdAnQkk
 C545sU0bSF82dXLyFDVNTOuIkYdcb9GedopLyy5AQcZRCu0SJVSHgffTHYvSS0qVJn0s
 SIi7K8htuik8FRjrr86aRkp2iG8ZWe0dnrKucODYzXmeaLvoWcO6KEO3Bzmzdj0LlB8H
 3RQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ioOyb4xG66q2fTLfsGfTYAyFHyWO5rhiglb9JNcxXHI=;
 fh=+9TrFTfrJYazmT9Pipi0F81pjAcROGKFusZbTAVcR5Q=;
 b=oe9B4sd8//RUuUdBHLBBt1ui5WdJXS9dqnQG4F5hUbVaARbkHpe+9qCcxU/HrNuadR
 mQTJa3TxplVuwfydpk7Z3/mCOZvf7z3PQuYlJoc0OZhrEDij8XdGg/d7E/42cDSYGsT1
 jr/ZpC11QdsSUaktaVI1tesuRYlA1MzBnqkbb3a91U/3e07JUt1Oyv2xiLj0HUYpvZcW
 xbr3PyVgCGrN9N/2wdQy1RzcpkK9vIGKN/oWOAksI1URtkP/OSjJW9hsiMGyV009rI9m
 deP8Rr6TUAXmG9Lj1uAztmx7NW20PRHPEN6G9vApsS5BxlEwRUsVRR38L05C/RJoPPV2
 lCMA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793574974; x=1794179774;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ioOyb4xG66q2fTLfsGfTYAyFHyWO5rhiglb9JNcxXHI=;
 b=RcPFopmwgXYmQFsYru+sA7kn6IXhVk7XbANoUiS3xLHkW9AYJyjhOqcYXIaJQqHCnS
 qe2ZLDlR6Rl43fownNhoyh3wmmgxvyRQxbGikpkobYjXOwgFQSpuXXTmM/UbsH2KfiBx
 CueFO96C9TY/M+Q7vak+UrCoGThXLBtHg9R4iHqt+ODfl0xdY8ulRfpET52XhNo9QnC9
 IyYctR8H+rp0YgpYpC9zmuL/2xOcUMiW1k6/KQ2IqN/lC3WS7jGVrz7lT8y+8NAi94XC
 T3bwbOiPcciEz6RzSzzYi3FDaZY63LEmdBJ4zBM99zJpz6JnERjEnLxrujLyKONmD2Kq
 53Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793574974; x=1794179774;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ioOyb4xG66q2fTLfsGfTYAyFHyWO5rhiglb9JNcxXHI=;
 b=GSM3bKrRdh9DFmJ3Hn2gfHPTzW7fwZDqHH3wDvMso4gtheX2HGXIjiJxcGlV6Qkdfa
 +TfkNLvgKSmt/UCnmCsFq4BMX7LrI0sfH7shxEvF+t+06cAgw2AKRgVuMdwHn27TWUT+
 8uVXfFsVRia8h28kTwJ6NOxgqTWnIvSiiw03xcYENwdjq+KPn1faDVdIyw7q7vqgph53
 +B2D4STiGCOzqAVWtg7byjaeg7rK83AAZBZ59AbaW/hsqOeSdUyCPbeNxhpS+5CyiMX4
 flPnI5PCKPeyfuBMOXMeLc/XRPIa2q1lQk5zcITQfNBmhV3ClGhIlUEYH9zcCMf7kfAK
 IgwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByLjrbZnaMY877EZD8+NHEVGnpZ67ZMGsJEsKiADu1uWSp7/UH/wLnfAGNXoC/bAVj2GIx341wKC1g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8CTm6u4ZQoV8kMFgcnu5vG+oDzbI1YRnier/enK+D98ndEV24p
 8fuDMMlOu7UhPntrYYgdqi0iQFiCBQYaR5jdCtuY1QhwmjIVyKn5F3NwlqtAgVptObbkQQqPzWl
 g6Cpju7ITTf3U3hyl7RoJpOczU6ELl1v/DP8PVwSk
X-Gm-Gg: AYBFou1Ej5RXNhlyuV60I1BsZLe107WNhOXuHted3xNrbgFzrWz4/TXIKh4fNOVpCFM
 U1meryAJmaKTuJ7Rx/aHUPoUk4Tv5JC0pHHVIECPfe5KuAUVgKOdPjkwDBvcfUrJxlPH+5/aGUd
 RknELth5EoFXI4dqMXCLzrBDTAAjUffPLFb/X4Eb2+5p0EoNVWIj9wzD79iPYdyfWz1OkU7PElZ
 f3lrzPNcBTuoUecwQtAohPPR7sBRzWJ751WD/iWDXiC3+yLAiuxGDm04v3/ZHBUcR6i3gKyobnp
 uXXiTqdXIcU5xVnUdrCc+uwHSny3v7WbsAFsJDtqByzC4J/5nxMP6U1zWcjh5ts0rKaBV5r5pi7
 lJvjH/4S5qVwu6vZB9tUD7LGEUno0rdXxydCXtwA=
X-Received: by 2002:a05:6402:2154:b0:6b3:f12d:7405 with SMTP id
 4fb4d7f45d1cf-6b4b42a63d3mr252843a12.14.1793574973443; Sun, 01 Nov 2026
 15:16:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030083539.777877-2-almasrymina@google.com>
 <179357408146.3131.2882435952119280563@kernel.org>
In-Reply-To: <179357408146.3131.2882435952119280563@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 1 Nov 2026 15:16:01 -0800
X-Gm-Features: AclHuK_Z0S06xrAeAq_HAO4Ko_jHw-2goCa0w2rOFRiQDckpwHJNSPwxMM9jz2A
Message-ID: <CAHS8izMt+5HBjkOOsb-FrwKoXxEBuDn=gf5p+64akYS=SAoQrQ@mail.gmail.com>
Subject: Re: [PATCH net v5 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, pabeni@redhat.com, sdf@fomichev.me, 
 kaiyuanz@google.com, kuba@kernel.org, bobbyeshleman@meta.com, 
 asml.silence@gmail.com, dw@davidwei.uk, ap420073@gmail.com, 
 davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org, 
 andrew+netdev@lunn.ch, sdf.kernel@gmail.com, hawk@kernel.org, 
 ilias.apalodimas@linaro.org, daniel@iogearbox.net, razor@blackwall.org, 
 tariqt@nvidia.com, kaifengw@google.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 1, 2026 at 3:01=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The dma_dev use-after-free this patch says it fixes can still
>   happen for RX bindings made on a virtual device that leases queues,=E2=
=80=A6
>

I know about the issues with leased devices. That needs a bit of a
rework, which I have done locally, and would like to send out as a
follow up fix.

 --
Thanks,
Mina

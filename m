Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52917CA600A
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9146810FC84;
	Thu,  8 Oct 2026 07:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ImWKRJJP";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA1310FC83
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 07:01:54 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-81b54d0cb17so2287570a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 00:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791442913; cv=none;
 d=google.com; s=arc-20260327;
 b=gokOlTXHGD9ri+2rSQAgqH/LP/iOb3AQ/gW0RI7FjfaELCgZGTgGRqZLLJUNYj5/Iy
 W9FblEI5Mao0ladnsirLN/QKnblG3ZLl7iTnhoGPn0Fr72BLnDr76LPrkRZar/I/xwPJ
 MwqakaSrMb06R1abfc3Zmm/utCp7jhDtoAXvk0Qz0sG/LRCVERdd6WB+Ac6v+pAwN8my
 Ha46zZu3+AjAMn5228MgFahXiFDKZ12c3PMPgobuJ0L8TQ6L2v34oY08tlLVuj5W9BbM
 TbnzcaJONcqLdI+hpbYh5D391rmTY0nszRcaeyNJa2c922jQqEuL6m4XX5eSIB7oV1Me
 eDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VnjgZpiqCBnWQmDzV7ayfji4vld+Ysm4KsVus+ufOj4=;
 fh=lPaCkO07BNLum1Dybkp9KGFEBShdc1JamAzCBMNTfx0=;
 b=pT/aRB4OYJ9nF1QwliQwgs9RKuplnBwuAZRxeO8+7ukeiqFls5R/vA2nWf0RGqkpGT
 h9rQqxZoHqzew4AHzapUZNGJLwa7VD5x5/P8QEsjfCy9n6U1RnI1oFyzvwrWvkFjUFAY
 LSeB+DiP5mOZx/6pxSlriMA+IEe/tmp9gNKfjZ2Z36+88rSgUKddw/ekoexkrXv3zA7h
 jIwQ18T8Eoqdm8plPWPIN1Pqenc5ZHoli4T3DBrxx/OA0dH8bkHF4fm4f+hxErSvQYeG
 w4m2uIVXR0LgLxDAbblKO6BbAntw8nWzTA+aKk3zWdeVsgUfoPX1w7W9OSpDlEG0FVXj
 p0dA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791442913; x=1792047713; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VnjgZpiqCBnWQmDzV7ayfji4vld+Ysm4KsVus+ufOj4=;
 b=ImWKRJJPrluEkjJ+Vfl4+BhunI/0RAtwetIbiYKViFQsCvfUiRR0KV941L+8OmHQR3
 qs3AlACFooCqe/4ySL8ner/qQ5v51y/OFWsxUkPETbWMJiYkTZeKOOR0K/tIhNYf8yn0
 oNQRETa8OZ26tJONeApTMuwrp83/K5ogJWOC6cpiyW7CNX/GuGtkJW5F2k2/MV1EgURO
 njrIGgGh6ecR5fAP83eWFyf6TZ6uODF6UTNAAWPnuPRxKol90oo7amqg4UoTS5z6NkNm
 iFE3PWgGw3OGTXFdB63QBoGJg12NwZqcg0nLU4bxEDLWlsxal8oIkFcPTU+fbUKJ4mmu
 lKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791442913; x=1792047713;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VnjgZpiqCBnWQmDzV7ayfji4vld+Ysm4KsVus+ufOj4=;
 b=qTfrA0K4g81eOK35Jykk6YnpToMXnI8FAVmo13GRH8f309laBmp+A6lMSah5w9gz9z
 JUYsGOAXkA0JtRVHtuazjZ4pXSkfeVEJ5OU2EKlvvHQPcPOpgn2IWF9vxu6Ph75WuoPe
 D2VLn4LVhFOus5wJzURHgwAHavILLLTW8Q/Pwb+xPv9b6t4edw5spJ8SwoFJBCzv1FE9
 DFC7L/erQPRvxx3Juwa63QtIBEsb3JfobEVFOjFu4VR0ft5oMyIxSnvyJNWKrRah5+mh
 yLR3P72qVAGGB7MGCHMEVuKkRc3w6jFXA978WQT4E/kvOtdVc+o+vXPETObX099yzChl
 M3zA==
X-Forwarded-Encrypted: i=1;
 AKwUvByCUwMbEe/srvRQEJWZURzf8HL3xw6/9h1ob+hGAQ4Y56Jg8zpaXW0rrui+9Pe06R5WzNvliSHZ0fE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mjp5+SqGgetEQ/qZ1x2B/j07gyQoUxYPwKWKD5ijy2Wxupdd5U
 jJY0W6u+4lKV+rXHt1+P2gaTha8MV6wmFbXWopbcMfdoeXPV98kDXLbKZOGPzPOrR9AHoHhrKk/
 KXdf1W23g/J+9D7UOONWnqB1vV5Hyxrc=
X-Gm-Gg: AYBFou17deyar/mHWLO0P+wMfjpgTKAzBKDWaYbHjUnjskt2ifvnIyaTR28WRDvjhUY
 BAm4AruGKHDAI/wj6wM3aUcHKVqCdIHiZ5NWgtChg7gHT2r+59ENWPiNfQ4wyMhUeH/rJ5v01yP
 jUAIsJxa/I2bHXgm98KLD/RQcBr4XziG0iYprLAgT73mAg41BlIKfjvnYzxkmedFCTcCcvZ0sUl
 Lsu8Riw2T0MYkR0uvY6UG6LdurFgl6PWATGwp75D5Myvq4fc/wrehtPbMqSZnEbHPEY95bLICif
 vDsxik9gFsHmbDQVpe2so8H8BDPbH7xCk5ntaBBiyCZSI46F1ndVw0vjICVKKhaWi7/HHkJBJBU
 pHblHDZDS4g7SxgocR+gw4GLkNu28XC7I2j25Nge6otyGuhTktisH
X-Received: by 2002:a05:6830:25d3:b0:80c:d30f:97d with SMTP id
 46e09a7af769-82ad16d6194mr5557685a34.30.1791442913372; Thu, 08 Oct 2026
 00:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260829004608.25252-1-mikhail.v.gavrilov@gmail.com>
 <20260829085941.106318-1-mikhail.v.gavrilov@gmail.com>
 <CABXGCsNQZY+g5AB17yiZP4aD3eKBpNWWNqcOL3_eh5JLxp=H3A@mail.gmail.com>
 <IA0PPFD4454CAA918D3DA3D71405C9C7FD6FC932@IA0PPFD4454CAA9.namprd12.prod.outlook.com>
In-Reply-To: <IA0PPFD4454CAA918D3DA3D71405C9C7FD6FC932@IA0PPFD4454CAA9.namprd12.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 8 Oct 2026 12:01:40 +0500
X-Gm-Features: AclHuK9yC09SUFDh4Mtny64tXmLQQDmS3U1PZKcvsixYfz550FQvCb7EW7S4RLM
Message-ID: <CABXGCsNGmbFYB2FtAi6Hzn-jPTy6YG7P_Y82Qe4hi42svcq4xA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: add missing CRC engine 1 registers
 and masks for DCN3.2
To: "Lin, Wayne" <Wayne.Lin@amd.com>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>
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

On Thu, Oct 8, 2026 at 7:25=E2=80=AFAM Lin, Wayne <Wayne.Lin@amd.com> wrote=
:
>
> Public
>
> Hi Mikhail,
>
> Thanks for catching this!
> Could I give another patch that will include this fix along with a few ot=
her DCN fixes, please?
> I'll make sure to CC you when I send it out later.
>

Sure, go ahead.

Please keep "Fixes: ef45aaf73717" on it, so that the fix also reaches
7.3 stable, where the WARN is new.  A Reported-by would be appreciated.

If the other fixes cover DCN2.0, 3.0 and 3.1, which the Sashiko review
of v2 pointed at: their offset headers define all twelve CRC1 window and
data registers, so it looks like the same addition there.

When it is out, I will test it on Navi 31 (DCN3.2) the same way as v2
and reply with a Tested-by.

--=20
Thanks,
Mikhail.

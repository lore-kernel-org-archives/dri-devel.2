Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D934BCD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A81C610E3F2;
	Mon, 25 May 2026 06:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sewmbVmj";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE12610E095
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 20:50:36 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c795f441ff7so6539604a12.2
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 13:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779569436; cv=none;
 d=google.com; s=arc-20240605;
 b=W/2I2gVU6bHtnOsNpG9vT19w6ZRwB+M02TVO9TG5Mn/sUToEkk2y+mo81Or6qd19R3
 1e4UGIMPQHhJUTB71a0RR08tgEE1/SgY1uEa/MZshfai0efYaJj0k1WnDwHxrvyvCKOP
 BVxFdk9tqORMLoqrqB7on+mJWQ4UxipDpntGKT5KtB8k8Ncgdv5HxGEPFkUNXu+PdRvV
 KjynL5CFkTYw1boY90Wf/LiFy4R6OvX6AArklHGekfnU5P/QwT1zjEn89CKRC5DR7tgt
 sMtybk9jRph5agiwDBG4VByPVjcG8RtPjGjsyiJBJNxKCiko4bb9GIiSLs5fVd9wq38k
 ILDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IyTQ98dxYkPfqT9yOtXNuJEPxSlMOIrwYBGil6h3LZ0=;
 fh=wyXZkJCYIlOkdTRtQ0lTnFCiG+aCmUPJXkZqTdApMbo=;
 b=RmDqo8PQ9O6wudyrn1tIcalpJv8JMVpCBlHIy24hhqjhsdiWyq7ClHvIhyfXRbP87t
 FCvZzfWoYURKn3mhYIYLP8MfmxBwLftEV+TFvGHub7y+EF14rst62O1J8ziL3yHh0O6l
 X/dUxp3D1qvWK/oUGZta9bXhyuOEntWej9ExpdUrde5QeM9R3cGLAseSHr+Z4PaW4VhY
 dSRa8TKs1AREynDvNOeRGRfrjprNa4Q+8xbzY0rcb91Y7ujsCzB92BCdzlJxDeeVnRZO
 RjQtbOihRdhC4epyZvjcZuomGqeVKaLLHrdmRTSC/KYFHv6nGLKUn3m4lpbvCjLCrSwF
 hCZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779569436; x=1780174236; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyTQ98dxYkPfqT9yOtXNuJEPxSlMOIrwYBGil6h3LZ0=;
 b=sewmbVmj8rCgVYV/e0JWs/1Vf95PNIcbnoksI1xT//9Cl7XLkdnrBvpN7nQgsyCnFC
 qSPAcO7038sQWctLy3pHCh04aOiWGnWL8v1yCUtHoZ3RxWeSfqjIkaLKAa+riKATloGP
 hxkMBH9/D854ZtWOXzR69AvvUdeNTj+/U1H+6s+SxjD0E7lCa3NO0U+e1LmxvXzKWFN9
 AkX5GiXMX/pFhFU0O/AVHjvc5fXKH1Gq3sRLH8EkuYjJg7rMMDBc+aB6b3H6fb//zcpE
 Y3B9Gn/T/AFORKQlVkas/ucjOgdITECubwK0EbTQKVa3nlOUiJgs0B5O0SUebObuOqVE
 2ZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779569436; x=1780174236;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IyTQ98dxYkPfqT9yOtXNuJEPxSlMOIrwYBGil6h3LZ0=;
 b=mYVmzi2ofDMfC9Sld9pKJnSOiy5sJpnGUYGuFLylLZ3RjqZ8uQuNQeSs/OkffeekPk
 YKS8r95eEmFH+XULHr/W8/qpwXxGnQhdfygpskOeKorRxPexyZh9zONnaI1DHwdEK+O6
 0DgYC2WSAivN7yhOLFf87+pAD9oR04wc0yJo2oXYh6kkoZGkKlTr4Ew+vkLgkNumydh8
 0x3op1uValt+Jijk9TS/MPDlo1A3cOZscwh+EoNkPpE40w1dChYBkuuC8hwYKr7lMOAt
 6/71JadvBUHVq0Pk3ftoOjv/oawOThQvdjYPPPIkR4lOkGRVBSC1zF8STgz8tj8ldaiA
 yRzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GiPxBlOlqndFZ/6aV+xay7St6zz2YcwE9nNzxUoHHAAlVijfP/Z7p3LgkNMywXF1XpxyBtTCbQPw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz49emZaWq7gX5pKXhsD1EALKunTK7lrQekXohrDjjp75NbMzg9
 qLPGAVM41qff1mi9UTsux+/9PDuwxmfqQmy62k80UbhZyLrSYriDhwfRpHEwUV7vDglhxLeDvmP
 oc5pEY8MldAGcSOfgb56yj/ffQIlmHm8X2A==
X-Gm-Gg: Acq92OGw9rsfmwZNeTFtjzCZa0ekzyBoQGDDt/pMMGUtb0R+h1pLMMi02MZEBDKHZjI
 F4upcdISrD28YX7ANMIan+N9cMc47zardb/62X5cu3Kw5SJDdFp1q8/dT5zwlB5A3NStVRGgL73
 f7xuw0k/loG44JrzZCTBCZQLuaukHBeJoNTVck+sXNfK/9at6hgSKWP5nMsPlRVffLFMPu5KAkT
 cmENUSmupC8I3Mln+dkGT91VVXePtP2/WnHJy/3zX6xsiBBxGTPQCitCKiqlccYQa28BbhCC06S
 0cCgKOdtmpIAg5q32lNlYzt6kEPKgdqSD2kSQLVV9pWcQc7XsPJxj8IPa8g9oyrlEc/4HZrr
X-Received: by 2002:a05:6a21:3285:b0:3a0:adc5:52c1 with SMTP id
 adf61e73a8af0-3b328c4cbf0mr9292019637.11.1779569436223; Sat, 23 May 2026
 13:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260430010405.52591-1-kenner.linuxdev@gmail.com>
In-Reply-To: <20260430010405.52591-1-kenner.linuxdev@gmail.com>
From: kenner azevedi <kenner.linuxdev@gmail.com>
Date: Sat, 23 May 2026 16:50:25 -0400
X-Gm-Features: AVHnY4JlT12H_E0ODt_22_aaUdV4UquI6AiBAxfDaGZ9HELRKphl73htp1x5-BY
Message-ID: <CAFHy_waHvX5cDPu4=7R4nQzWBudYP2BwT6aiq0jHf4nCT3tGzw@mail.gmail.com>
Subject: Re: [PATCH] Fix kernel-doc for amdgpu_display_manager
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 25 May 2026 06:20:29 +0000
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

Hi Team, good afternoon.

Any update about this patch?

Regards,

Kenner Azevedo

On Wed, Apr 29, 2026 at 9:04=E2=80=AFPM Kenner de Azevedo dos Santos Mirand=
a
<kenner.linuxdev@gmail.com> wrote:
>
> The struct boot_time_crc_info is not described in amdgpu_display_manager.
>
> Running the `make htmldocs` is showing the following warning :
>
> WARNING: ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:715 struct m=
ember 'boot_time_crc_info' not described in 'amdgpu_display_manager'
>
> i added the description that fix the warning and describe the struct.
>
> The warning is not showing anymore in make htmldocs after change.
>
> Signed-off-by: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmai=
l.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 74a8fe1a1999..201b4796b591 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -347,6 +347,7 @@ struct hpd_rx_irq_offload_work {
>   * @dmub_aux_transfer_done: struct completion used to indicate when DMUB
>   *                         transfers are done
>   * @delayed_hpd_wq: work queue used to delay DMUB HPD work
> + * @boot_time_crc_info: Stores CRC information collected during boot
>   */
>  struct amdgpu_display_manager {
>
> --
> 2.43.0
>

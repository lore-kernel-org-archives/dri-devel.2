Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C784FC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D952610E80B;
	Mon, 21 Sep 2026 21:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pf0u2ILj";
	dkim-atps=neutral
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3618210E778
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 21:31:04 +0000 (UTC)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc1ab16a9b0so12612a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 14:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790026264; cv=none;
 d=google.com; s=arc-20260327;
 b=NYpB3i+/u0z26FSuwUffTtdgTkTRPj9bZJuNW6P6xzgVx76NOj+oMaVDjjSzjV+yPP
 0aMdZDzDDVEnhlS8db3O6PXDsDydQxLVUSipXtypABdiB8Pkc/j7Pdo+fji+Uuu5FgK5
 IPwOgoxKZ4roicYAKHWtPKkFlLka4fGp+ngYALPQmSoXRo+ChvBIPEoAgoGiwtqO3eqC
 TVsfNdbhsM6wzFpsqUgzhgRSwzMDeGoNhGf0bFhKKJelxV/7EUAG+e/BMbqKN43qijMQ
 v1n0JpsKayKFoxevRjc5UHLkmgH/0kL1myqTHLpB88zr2z/WQM+//ycKNO2mUmfRvBU9
 v6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=npM8Tm5310J5ykZ+cQxb8lDmWPmckdFtiw8vnwk947g=;
 fh=Yd0CCfmW7RTYQT9ZbkdP7+dAd+QNTWczRep0ZuadPqA=;
 b=soFLoMv7c1bkSWZwv81CgyrbaMO9Ne4M8pWxmoloEauRdeFMCiXToRdTJmoCNPdzIu
 gNwYEdbpa1M1HLPy7O2rE/jG8ldxSqddOKFPXwFIO1sWmsCUpM3fEHDpeQt+s1FaHVSR
 ACt7UTJSZC7Q6lOdp8IlMfFy9M26LucXoJTkPCrePRyYDSCaEtzKUhfyBPRS+R6Hafjp
 EbNSluByhR/jYSLKjZgcyp5ixbc6GFajnXUaWA3acrfWqDH6yPpevbHvZKlpoCXe9PZX
 0pN2oszzlcY3ifZ4VWBujsLOFi50CCT5p4rD5UaKjvCfrj6PPr3KnsKramwGCeJaXsp4
 /EUA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790026264; x=1790631064; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=npM8Tm5310J5ykZ+cQxb8lDmWPmckdFtiw8vnwk947g=;
 b=pf0u2ILj5NgvU4MaKHGcwfYyBppD/F2rHVZkZ02whU7JyLPVTHkYQkfDi4rCioOFcM
 FCnnecqV7Ssd+c5zXmzACKeiT/NXs+IHAs77YXFC4iwFLT+USKigMrwVPtKTRVzLepva
 fOBxMRKlO3rI4Yn/IqPSmdlf2BEW7rYfUkI9zPXIQHrYIiABaQcOoaU0F+S0mB8xB2Vt
 6gooqLzULVqf7t1pNMGm7QrPWR4CcTZME7uFjiIQ421geN/lfTI+QUvSJcts3nGHxIWG
 QtrHpmd4ww64VEhRXHCQ4tAtY32mc9PJfz4ZjGFo2/HcxWxcgA5FMfEqgWGm9ojp0mso
 dr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790026264; x=1790631064;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=npM8Tm5310J5ykZ+cQxb8lDmWPmckdFtiw8vnwk947g=;
 b=XadjF5iEtO3oZt/Lngg5d8CVYW2Qz9l92LXJDA0O9ASwsRT6rIG1KpEtzs98ieWo66
 tprIAFc7b9dTTPqoYe0ZPLPXSsiApGi6OBvW/y075Y7i0C6cd6qPYNEjxuODRyTehRUS
 x3ysu+xOjysD8ebWeVabWjVyV0nvm/yG+EvjY+pmQf5JjLrHlg74MCMcPmzzxdHqNFds
 sU4QmC6JnTjqq/0UTMgiU2ttthBkj5Qk9yrzMupa9Z8tRkAoDsMeCcZALDnPkWFska61
 O8z4zSY95zgoS1hNGlIF3EYKhpP1lbUtPdeqhJTqEsdMDa0OsG8KzmKowgKzYmlSRghN
 PKYw==
X-Forwarded-Encrypted: i=1;
 AKwUvByYWG1JraUJq8pOIPGm6rT79XOFwVeGV44SutnZcsmeHRWnUz41xEgwwuI5XCR2D+g1gw7mv39a0M0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ncKfw0cp541cYOKz2TbDf/EkHv/I/HQeQHZZ2zJUxRyOJe8NC0
 0vD7b07tAgPG73Bs7zeCn7jzaUxYbzqoc6+pY5tmhwbf7IvLKCYd72Rx+SSyml54WUthLm2uedk
 PVKrYkvZb1avqAAivaT6JzsY3vMrJ2Sg=
X-Gm-Gg: AYBFou3m9WyaVXVI/OBDc9HqFgydavg+YaGh/B+6OqqomAyFhIi+/GdqH0LZ4rdWJ+R
 4WCUq4sOoJmakAx3jzPrPdMXLG7kSQuz90iRgaIRlIxzHMHgcCqLJv23JVIRapWOXrbwMe/GdWR
 bTntqQuikYpSR+PI+KDlWFA6/CDEdhqGYGdDkAoDAURJzE7WuH3swCKsHClrEK87IB69EBR2gxm
 IGXa6Ux66qmZiskArIpn49F3HQrCxpJCZOsa20e02CpQ5+dmHE/bJheW2Adxf6TVoDg4d4XK3a4
 KkEKf4qYIdswYTaIyl4dq/U2dvVbhIu0y9F1Ry0uljVxW5ZQwNw87Gxs70y+c2HyUFEkf8Ah1Dr
 brGI+GcWbB8O7owADPxL6l2pkhWYf9rDRwT2kxoc3+OI=
X-Received: by 2002:a17:90b:58f0:b0:39e:261:4e13 with SMTP id
 98e67ed59e1d1-39e54f42eefmr24972615a91.3.1790026263555; Mon, 21 Sep 2026
 14:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260920062510.166584-1-yaolu@kylinos.cn>
In-Reply-To: <20260920062510.166584-1-yaolu@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 17:30:50 -0400
X-Gm-Features: AcwNN1WjjOBi88To3FSq581QqCOsezWgyru8to2rFEhGCyGgtBQdu6CsObQOUn4
Message-ID: <CADnq5_M19JOb6kSwUi6juWWSpMtQZtWazw5VtP7rhr5ZvC0-iA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: drop KFD_QUEUE_TYPE_DIQ note
To: yaolu@kylinos.cn
Cc: lingshan.zhu@amd.com, Felix.Kuehling@amd.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Sun, Sep 20, 2026 at 2:25=E2=80=AFAM <yaolu@kylinos.cn> wrote:
>
> From: Lu Yao <yaolu@kylinos.cn>
>
> Commit e1b73b64271d ("amdkfd: remove DIQ support") removed the
> KFD_QUEUE_TYPE_DIQ enumerator from enum kfd_queue_type but left its
> description behind in the note block.
>
> Fixes: e1b73b64271d ("amdkfd: remove DIQ support")
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index d8631847f0eb..2847a5ec5ede 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -430,8 +430,6 @@ enum kfd_unmap_queues_filter {
>   *
>   * @KFD_QUEUE_TYPE_HIQ: HIQ queue type.
>   *
> - * @KFD_QUEUE_TYPE_DIQ: DIQ queue type.
> - *
>   * @KFD_QUEUE_TYPE_SDMA_XGMI: Special SDMA queue for XGMI interface.
>   *
>   * @KFD_QUEUE_TYPE_SDMA_BY_ENG_ID:  SDMA user mode queue with target SDM=
A engine ID.
> --
> 2.25.1
>

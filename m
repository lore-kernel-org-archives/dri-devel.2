Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43405C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F5210E556;
	Mon, 13 Jul 2026 06:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mg1CT20k";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77EA810E556
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 06:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aFXP8cQmdcTent4eO19k0k1vw+AqjjgOWTJfbGUYqH0=; b=mg1CT20kXxJ5gwS91MIDF1EQP6
 mNRgtU6B5c//r1L+1EpIGeI/rgWTht1vnWMWV9NGtGu0yOJCvS2f7cCFVuc4BrIsrRrPJGLnLPXRg
 jaPfcS+rrvZDy5TCruTxN0YVlHWIAO0oyiC6888/IHK/iR0paPQARAwwkcKOc4J2SwRPOjOPhQHsx
 3NhrhIgYmGn9SDdVoh4Rlx7ZdBhGCtK9dLjEw1PTjNbeJTfiVligqL/Wi7MbrZOhSD6PRRrHQjWhf
 w2MKYzjuR158kmXt8GVq+1AgN/n99uSgr6d8mOv+Kp7zkxvp0iolw3SfQJtiTX+lUwIIbLMkfPIy0
 V3cmdxxg==;
Received: from [159.147.19.205] (helo=[192.168.0.17])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wjAFo-00EN8A-Ck; Mon, 13 Jul 2026 08:35:00 +0200
Message-ID: <d575adcb0a5c5eb4b4a85bea2c5a778fc8137a50.camel@igalia.com>
Subject: Re: [PATCH v4] drm/v3d: Associate BOs with every job that accesses
 them
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Date: Mon, 13 Jul 2026 08:34:49 +0200
In-Reply-To: <20260710114734.2731000-1-mcanal@igalia.com>
References: <20260710114734.2731000-1-mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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

Looks good to me:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

A small question below:

El vie, 10-07-2026 a las 08:43 -0300, Ma=C3=ADra Canal escribi=C3=B3:
>=20
(...)

> +/**
> + * v3d_job_reference_bos() - Share another job's BOs with @dst
> + * @dst: job that acquires references to the BOs
> + * @src: job whose already-resolved BO list is shared
> + *
> + * For submissions with multiple jobs that use the same BOs, a
> trailing job
> + * shouldn't look the handles up again, as it could cause
> inconsistencies.

What kind of inconsistencies?

Iago

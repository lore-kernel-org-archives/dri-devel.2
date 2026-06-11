Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C3DCD8C9D
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 20:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC0210F119;
	Thu, 11 Jun 2026 20:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kU4stwrd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7164810E85D
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 20:26:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 558FF40258;
 Thu, 11 Jun 2026 20:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E8A1F00A3D;
 Thu, 11 Jun 2026 20:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781209561;
 bh=6zlJFN/HEpTR8xyPqOhnp5pwp1s2MlWgWJgNeE8EIsI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kU4stwrdrO4l804v7P+zWiqrpd2FJ26/yFu5rvOpDSDRu1wG1YBRn/Yees0sQPR5Q
 NmbcIFx/FxhnjK4DNdYGv/rgcm52FES6aafKVdDNimcK2Nbgl30W3cv4GiY9yJ8+nb
 6SWJXO1eR2T+hBPfUhM4PWEB4zhfTn1Hej2LhaFxCIQZ9Vr6zQ9kJRwJJgPmHGsNY2
 2uL2BKMlLeB/L0lFSIK/dI+ZPWnyoNO9GaSBI58CqfUhQ/lY1LQ1LcFmbzFfwrVumr
 E2e2ms5Q0HwbSZ1KZx+BP9ddodkxAS1YXf+Ln1CB4mAb1rxGPT/F/CPlYZ+pYYHXOn
 A6aruCo5vUZ6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] dma-buf: add optional get_tph() callback
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260610193158.2614209-4-zhipingz@meta.com>
References: <20260610193158.2614209-4-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 20:26:00 +0000
Message-Id: <20260611202600.E1E8A1F00A3D@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> Add an optional dma_buf_ops.get_tph callback and a dma_buf_get_tph()
> wrapper for importers.
>=20
> 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces, so
> the importer requests the namespace it can emit and the exporter
> returns the matching ST/PH tuple or -EOPNOTSUPP.
>=20
> dma_buf_get_tph() is the importer entry point. It returns -EOPNOTSUPP
> when the exporter lacks the callback and requires dmabuf->resv to be
> held while the callback runs.
>=20
> The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> mlx5 as the first importer.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610193158.2614=
209-1-zhipingz@meta.com?part=3D3


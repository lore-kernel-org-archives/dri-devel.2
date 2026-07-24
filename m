Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3B4C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E44DA10F49D;
	Fri, 24 Jul 2026 22:02:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O6zOSgs7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE7010F49A
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 22:02:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C5E3543833;
 Fri, 24 Jul 2026 22:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484401F00A3D;
 Fri, 24 Jul 2026 22:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784930524;
 bh=lJOSCc4sF1P23gsernjs7QoxWU1uA3uVqtHIanV38ZY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O6zOSgs78LEwfcElJMc0lYX9WXcrsJgmN8GgWBBHxrX6skC6a9zxFR7JZTdFsnPGU
 ra7r7DjZqbXfgiySrQVW6Sj+neFW/ePqjFqRskPyrokpk79blEo4RQMc0A2WtWdkwd
 SfartRyiVHWOxSe/B1MfpIwMvubO433sNoA3aiPo/R1+TvLy1XHqF/errS2p2xgOz4
 INPqS4YVYdNjVZmkpp0+f1/CsZO9pJaDoIehCL2o1q0VjlxkGgQ917TBWWsxAQLkCp
 0b9vB5Lmv/DeZshwiQhPbzMHnM8AUACS1Iq+tjTK0c1KKjrBEuXD+LG0N5N9XgP14D
 GkKT+ygy3Zrvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] ata: ata_generic: don't store pci_device_id
To: "Gary Guo" <gary@garyguo.net>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-pci_id_fix-v4-1-3580726844e1@garyguo.net>
References: <20260723-pci_id_fix-v4-0-3580726844e1@garyguo.net>
 <20260723-pci_id_fix-v4-1-3580726844e1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 22:02:03 +0000
Message-Id: <20260724220204.484401F00A3D@smtp.kernel.org>
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

> pci_device_id is not guaranteed to live longer than probe due to presence
> of dynamic ID. All information apart from driver_data can be easily
> retrieved from pci_dev, so just store driver_data.
>=20
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-pci_id_fix=
-v4-0-3580726844e1@garyguo.net?part=3D1


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D9606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=gbeLFUJU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F9010F83D;
	Tue,  3 Nov 2026 22:46:04 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F0F710F83D
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 22:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=NnJsKtCTeD/Bzs882oxMSZxOAfNjNWrgvAYK1w0KvpE=; b=gbeLFUJUs+ZWxMstd2CPZDNWCJ
 oEGwJz+eQinsoD8PgZ6HLv/YVXCRvnPBhA4Ww09HNNMGR8WL673bexx07d/W3ve1Ah4rdE70367T9
 ib3wl7UXqSYXRNjkkyk9XcaK0PWB7xz1cEIYWdHhRF/1mArXTlyg8mOL0Mfk2p6T0DYAwfrvSjzth
 7BmORiJf0icp2wMCCbv9zzVUGd+9W/QSwNR8jdlMaVyeBynCgDSRmUroyqnNbFAgiw0j4m8kRbfBW
 8XT6UxDlm1gmfj2ynLX1HCI1d+gah7Yt/it3CKT28RI8Fqk+afe3ABDn1leZnfRiCSSkctZWI+RhV
 Ri6bN5UQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v15 02/15] accel/rocket: take the completion register
 writes under job_lock
Date: Tue, 03 Nov 2026 23:45:30 +0100
Message-ID: <3317717.zE8UqtGg2D@diego>
In-Reply-To: <20261101082307.151957-3-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-3-gahing@gahingwoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Sonntag, 1. November 2026, 09:22:54 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Jiaxing Hu:
> rocket_job_handle_irq() writes OPERATION_ENABLE and INTERRUPT_CLEAR before
> taking job_lock, while rocket_job_hw_submit() writes OPERATION_ENABLE und=
er
> it, so a completion can write its zero after a submit has written its one
> and stop a task that has just started. Move both writes inside the existi=
ng
> scoped_guard().
>=20
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, i=
nduced reset, JOB_TIMEOUT_MS=3D2

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



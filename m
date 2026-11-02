Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F18A606D82F
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F87C10F1CC;
	Mon,  2 Nov 2026 20:05:51 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A6610F1CC
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 20:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=2cenlUF2waDq9KBfar6fRikPWRxkPdVSBNtni6dPSKU=; b=LKOwqKAsJdlPw1GinB1J4io/n5
 ZwAcvA+d70wi8SPJ4tA9ctBL9bQijMi0REP9exmzJl7o+PsactV9B61vHI50L24kJJjgo1QK+AHTg
 8i5P6S6bjpV+EIgxu/qcu1zbNQGiNX1Qzwc9N+y1tUnlepotz4BAPFoTz9sy0kyhKitcVcZpeWbmq
 XEFxZyCCI0oFzBnwS//th8CM7P+7vD5D67JqMpNgaskt0PhKNxrZEjZhBXCXUCN+17YUtwB75a+6D
 EQc3foAl9KEBWJOwF1wqn1E8qMcdKmy58ze8NmolhxFeHSVNO68rIpkKzob0wAK0llyKZjjr6KLw9
 oypXIn4A==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: neil.armstrong@linaro.org, Quentin Schulz <quentin.schulz@cherry.de>
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2] drm/panel: ltk050h3146w: convert mipi_dsi_attach error
 message to dev_err_probe
Date: Mon, 02 Nov 2026 21:05:33 +0100
Message-ID: <2958305.XrmoMso0CX@diego>
In-Reply-To: <fa346541-c877-4390-9837-1bdff86eb4f9@cherry.de>
References: <20261102161801.102464-1-heiko@sntech.de>
 <fa346541-c877-4390-9837-1bdff86eb4f9@cherry.de>
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Montag, 2. November 2026, 21:03:19 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Quentin Schulz:
> Hi Heiko,
>=20
> On 11/2/26 5:18 PM, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> >=20
> > The panel will happily report every defer during probe with an error
> > message.
> >=20
> > Silence that to actual errors.
> >=20
>=20
> You forgot to add Neil's Rb from the v1. Here's mine:
>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I wasn't sure if that carried ... because the structure changed, due
to the drm_panel_remove call being gone beforehand.



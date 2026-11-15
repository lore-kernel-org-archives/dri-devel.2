Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EB606A335
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=lAbr702A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D021F89D8D;
	Sun, 15 Nov 2026 13:16:42 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD70910E076
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 13:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=P/iZWwmcm3GJ6CC8MhWTY8Sc2xzYlGTS5W4HDt6HJ9I=; b=lAbr702A7r84NtQz1gujPywg4k
 yBT3Z0xSGQanL5I3/5xJUV+0Kw/mxXBjjQVHsF+Y65CpJPrGrjj1WvwqFPn/FKwmPvq28ATkzAryg
 7Il7K3vQmQ1CdSmPyCIxYdECs6NT761RlmgOQBsDViniBQ5rzBTlw58PiveEVMo7haTgv61jeyIWI
 wJDMN5VktCHa8leoByjVNmFuI9VrXrjzsNIRgbElQ8vk6JixqXyqygiUu7WCRi7OvhFpEVj+F3lRq
 xMrKretk6AlxK4EUzCTFqOaMsKlh0xRYsvyxrfiP4VxUeNPBrT33PkZRK3gl36hQ/BLdHMD07Asxf
 f+pybMTA==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
 Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v17 03/12] accel/rocket: wait for a running IRQ handler
 before resetting a core
Date: Sun, 15 Nov 2026 14:16:01 +0100
Message-ID: <hvfzY-vMTP2qEvT5CAWuhg@sntech.de>
In-Reply-To: <18667b2afdcaae217fa1038f5348ab23ed756bdc.1794615323.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
 <18667b2afdcaae217fa1038f5348ab23ed756bdc.1794615323.git.gahing@gahingwoo.com>
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

Am Samstag, 14. November 2026, 04:05:20 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Jiaxing Hu:
> drm_sched_stop() does not wait for a threaded IRQ handler that is already
> running, so call synchronize_irq() after it to make sure the handler has
> finished before the reset.
>=20
> Before synchronize_irq(), mask the interrupt and clear the raw status, so
> that the NPU core cannot report a completion afterwards.
>=20
> Do this under job_lock, because the submit path sets the interrupt mask
> under the same lock.
>=20
> Only touch these registers when the device is powered: check with
> pm_runtime_get_if_active(), so that a register access with the power
> domain off cannot raise an SError.
>=20
> Suggested-by: Igor Paunovic <royalnet026@gmail.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, i=
nduced reset, JOB_TIMEOUT_MS=3D2

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



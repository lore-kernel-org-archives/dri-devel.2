Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F75C4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 18:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ACEB10E35D;
	Sat, 18 Jul 2026 18:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="nElKzyxe";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82ED510E35D
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784400939; x=1785005739; i=deller@gmx.de;
 bh=5r5Q/hyKr3Ic4Z9v9az4NW/DS97xHygY7sQeR4ebiTs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nElKzyxeKIJZ9UHEzl+VH/byXJtg5Go/MoVaz4kNrvizVdXrd4llJVx62BLsBBL2
 1N2obmo1BKOeyfFu2ay1w1fUQhtgV/WCvNipxmU5WYk40IcTrrJ2XrzrDNd5BhtG9
 WI33TiRGvvnb9t0ikgsjc37O/4i2yDHyxlfKqwZxGJmPpnhY6BcPVvIM7MnnvQr2q
 N5cvrpljHvzXp/HFTlAaEORGekpTBX/v2z4D8GdVIYufSqK07AxE6MqhEOgv6sW8f
 PvOS3GNcuyYNDnKznjjI5/hdZgJbI1+c8SAf/hdo+9vingM55Od22YJMLlBtDYlsL
 Zas83+OXklLxybaEkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wyy-1whsPm3JK8-002Axg; Sat, 18
 Jul 2026 20:55:38 +0200
Message-ID: <59c1c9b5-e07b-4d98-9fbb-48c8fb1e94bd@gmx.de>
Date: Sat, 18 Jul 2026 20:55:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: sstfb: add missing MODULE_DEVICE_TABLE()
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260705001509.66078-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260705001509.66078-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D57e1gA24A8bp/Q4jGU+5zGyKTzLoN7WHl3ghKJabdm1oZPXPJL
 2Xj/NJaol9ni6ICkydivZdFcwn/qIChp7m0IjdB0p4VmaTLQ3+YaDQICr57/QcvArF0bfFe
 XLqHbNmempfeOLy7mhXArNWGYpm0EZTwEGA7cMYo3tD8zVufe/0zJkzBnTbGEU5W3szn26e
 VNEqtZrl3Pb0+wy7rZzxg==
UI-OutboundReport: notjunk:1;M01:P0:fLE4Ec8C2ng=;sVOnvbA7LEeJ4PZSUuIoTDOU4b8
 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
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

On 7/5/26 02:14, Pengpeng Hou wrote:
> The driver has a match table for the pci bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
>=20
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
>=20
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/video/fbdev/sstfb.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
> index 2ea947f57efb..2745557822f7 100644
> --- a/drivers/video/fbdev/sstfb.c
> +++ b/drivers/video/fbdev/sstfb.c
> @@ -1492,6 +1492,7 @@ static const struct pci_device_id sstfb_id_tbl[] =
=3D {
>   		.driver_data =3D ID_VOODOO2, },
>   	{ 0 },
>   };
> +MODULE_DEVICE_TABLE(pci, sstfb_id_tbl);
I'm not sure if it was intentionally not added, maybe because it's an
add-on card for which people should manually load the driver.

Anyway, I'm adding this patch now to the fbdev git tree and will find out =
if
someone reports a regression...

Thanks!
Helge

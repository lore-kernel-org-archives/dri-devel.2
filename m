Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BDCCD5BAC
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 14:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70A410E30A;
	Sat, 23 May 2026 14:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="V+dtONP3";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F04810E309
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Cc: To: From: Subject: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1779547190;
 bh=Pn12cVETERiqXM/KtCikTRcu1bEOhJ+MYUmkPE9RJvM=;
 b=V+dtONP3hbKIse3VBgIr2jJNubEvlcUj15geYJWmHLVz73CK6R26i/S7jXOJODC+Ev2hkmyFB
 mVWBKDdFc1P/lZY1A7PzvP0+4NfY8yk2xSbe1AOxgzYHnXGnHQMe8bvEVtLfh57QV+spZHmw9uY
 KsyWTH1QBil6zohtoSaGJBVh2KKQimpV2z5eOYKHNlw5R0nwuU/f3N0fXBZrK120ltCUUNgueKa
 Qde4VOsHOm+1GrKlgDfMzm8zsjBSgIWGHkH3wPkCqDg2bbJncVIhs0BZ0OeET4twgsDOPy9oUB4
 0SsOtyQNgljbfBFFGSlZPio8WfXBt28PbxjxLc1pBk6w==
X-Forward-Email-ID: 6a11bc340f40c56579f094b2
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Sat, 23 May 2026 10:39:47 -0400
Message-Id: <DIQ4TW7HUOSA.2U038AIIZP1IW@ubuntu.com>
Subject: Re: [PATCH NEXT 1/2] drm/radeon/radeon_connectors: use struct
 drm_edid instead of struct edid
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Joshua Peisach" <jpeisach@ubuntu.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Cc: "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailer: aerc 0.21.0
References: <20260523142748.50034-1-jpeisach@ubuntu.com>
 <20260523142748.50034-2-jpeisach@ubuntu.com>
In-Reply-To: <20260523142748.50034-2-jpeisach@ubuntu.com>
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

On Sat May 23, 2026 at 10:27 AM EDT, Joshua Peisach wrote:
> @@ -280,19 +280,19 @@ static void radeon_connector_get_edid(struct drm_co=
nnector *connector)
>  		if ((dig->dp_sink_type =3D=3D CONNECTOR_OBJECT_ID_DISPLAYPORT ||
>  		     dig->dp_sink_type =3D=3D CONNECTOR_OBJECT_ID_eDP) &&
>  		    radeon_connector->ddc_bus->has_aux)
> -			radeon_connector->edid =3D drm_get_edid(&radeon_connector->base,
> -							      &radeon_connector->ddc_bus->aux.ddc);
> +			radeon_connector->edid =3D drm_edid_read_ddc(&radeon_connector->base,
> +								   &radeon_connector->ddc_bus->aux.ddc);
>  		else if (radeon_connector->ddc_bus)
> -			radeon_connector->edid =3D drm_get_edid(&radeon_connector->base,
> -							      &radeon_connector->ddc_bus->adapter);
> +			radeon_connector->edid =3D drm_edid_read_ddc(&radeon_connector->base,
> +								   &radeon_connector->ddc_bus->adapter);
>  	} else if (vga_switcheroo_handler_flags() & VGA_SWITCHEROO_CAN_SWITCH_D=
DC &&
>  		   connector->connector_type =3D=3D DRM_MODE_CONNECTOR_LVDS &&
>  		   radeon_connector->ddc_bus) {
> -		radeon_connector->edid =3D drm_get_edid_switcheroo(&radeon_connector->=
base,
> -								 &radeon_connector->ddc_bus->adapter);
> +		radeon_connector->edid =3D drm_edid_read_switcheroo(&radeon_connector-=
>base,
> +								  &radeon_connector->ddc_bus->adapter);
>  	} else if (radeon_connector->ddc_bus) {
> -		radeon_connector->edid =3D drm_get_edid(&radeon_connector->base,
> -						      &radeon_connector->ddc_bus->adapter);
> +		radeon_connector->edid =3D drm_edid_read_ddc(&radeon_connector->base,
> +							   &radeon_connector->ddc_bus->adapter);
>  	}
> =20

Question: For all of these, should we actually call with connector
instead of &radeon_connector->base?

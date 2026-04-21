Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BE6F8925C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 11:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093BF10EC26;
	Tue, 21 Apr 2026 11:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Ezc5Kdbc";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A201B10EC26
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:08:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 2E6EA1A3383;
 Tue, 21 Apr 2026 11:08:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DA4E1600D2;
 Tue, 21 Apr 2026 11:08:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7C80C10460828; 
 Tue, 21 Apr 2026 13:08:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776769707; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ME++Jq8nnXhvqwNXblHdT9mduGrDUb+KHqBm+OQJIYw=;
 b=Ezc5Kdbcy1BZWalj71NCEM5UOwI1fcwzgLQBhUJOQXBEzy0qwaxFjYqqPfk9OZxXVIQnJD
 6D9Wjh5WUMlUhmTXB+jA+hOmUhwLM4LN/ZPFoNqRsctg/gQBIXpQiC5C5eXrXoMniod5Ql
 9OP0fMk9LfpC24W3ZNrqlPYfTGpogk0cad+Nusz0eqgWnv8cID8GN8m4AQKfv9NpWWA6cS
 o0njiJmLyfnDysUtS+d5uDDzXzvzpJKa7KhVxdQzQS3YolO4TMBmEap0tbHvFKDoS3zMho
 HDfrMNm7CVF9Fn+YCnZwAvBS4uR2Fn28WI6xq5Um0EmI/MSAlBZ5kSjteDuAUw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 13:08:20 +0200
Message-Id: <DHYSAK9P2RFA.WL1BXACGKTU0@bootlin.com>
Subject: Re: [PATCH 01/41] drm/display: bridge-connector: attach the encoder
 to the created connector
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260417-drm-bridge-connector-attach_encoder-v1-0-67b8b8fb872a@bootlin.com>
 <20260417-drm-bridge-connector-attach_encoder-v1-1-67b8b8fb872a@bootlin.com>
 <aaxyye3vsef56qxqmblv25mlwpjz5dqovblrgwaclq77tqjvps@kr3aec254a5y>
In-Reply-To: <aaxyye3vsef56qxqmblv25mlwpjz5dqovblrgwaclq77tqjvps@kr3aec254a5y>
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Dmitry,

On Sat Apr 18, 2026 at 1:18 AM CEST, Dmitry Baryshkov wrote:
> On Fri, Apr 17, 2026 at 11:57:49AM +0200, Luca Ceresoli wrote:
>> Currently all users of the bridge-connector must call
>> drm_connector_attach_encoder() immediately after a successful
>> drm_bridge_connector_init().
>>
>> This is an unnecessary burden for users. Move the call to the end of
>> drm_bridge_connector_init() so all callers can be simplified.
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> ---
>>  drivers/gpu/drm/display/drm_bridge_connector.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gp=
u/drm/display/drm_bridge_connector.c
>> index 39cc18f78eda..bba8327fe3f7 100644
>> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
>> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
>> @@ -1055,6 +1055,10 @@ struct drm_connector *drm_bridge_connector_init(s=
truct drm_device *drm,
>>  	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
>>  		drm_connector_attach_content_protection_property(connector, true);
>>
>> +	ret =3D drm_connector_attach_encoder(connector, encoder);
>
> I'd explicitly document that the connector is created and attached.

Sure!

I'd reword a bit the description, as I can't find a way to append the new
info without making it all become awkward:

 /**
  * drm_bridge_connector_init - Initialise a connector for a chain of bridg=
es
  * @drm: the DRM device
  * @encoder: the encoder where the bridge chain starts
  *
- * Allocate, initialise and register a &drm_bridge_connector with the @drm
- * device. The connector is associated with a chain of bridges that starts=
 at
+ * Create a new &drm_bridge_connector for the @drm device. The connector i=
s
+ * allocated, initialised, registered with the @drm device and and attache=
d
+ * to @encoder.
+ *
+ * The connector is associated with a chain of bridges that starts at
  * the @encoder. All bridges in the chain shall report bridge operation fl=
ags
  * (&drm_bridge->ops) and bridge output type (&drm_bridge->type), and none=
 of
  * them may create a DRM connector directly.
  *
  * Returns a pointer to the new connector on success, or a negative error
  * pointer otherwise.
  */

Does it look fine?

> With that in place:
>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Thanks!

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

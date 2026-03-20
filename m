Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E1D10987AB
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3178D10EBC8;
	Fri, 20 Mar 2026 16:42:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vgthYYBC";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFC110EBC9;
 Fri, 20 Mar 2026 16:42:51 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id DA4F0C5668D;
 Fri, 20 Mar 2026 16:43:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5FE0E600E0;
 Fri, 20 Mar 2026 16:42:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EED2110450CB4; Fri, 20 Mar 2026 17:42:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024969; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qg6IbGXWjfVAnRxGx77rFZBUXDaj+DssoskePXce2g8=;
 b=vgthYYBC+WS1Uic5VUDyktKZIPPHYJbsFmoOYHXL4xJ1b56iIkawe/QsrymHUI50OukdWe
 L5qnGsaQ0UTlbZX39iELz+JkrU7etVyPOAcnkW+qG6Po4f5quEwDrkZsu/0fga7nRqxzW2
 hdLMaktF0RPTti2T3uSvYO82uWQF9kXJt3vgQ1p9hANEjNxP6SeMT+kjewBJ6LJ4ngSkRg
 IJUErDMOnIEnPFiRm9dk4wklR0fXUfSYqS4EuWbBRs7NEFroJpXzRRRByR1rZfsM6Ca7Vf
 xzUEmVY6SL5ilCZNtjWDORkmZFpJ+Hp+WBMeZcEvqhJ93ScXvCI03R0svFeQQA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 45/65] drm-dyndbg: add DRM_CLASSMAP_USE to virtio_gpu
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, 
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, 
 jani.nikula@intel.com, ville.syrjala@linux.intel.com, 
 christian.koenig@amd.com, matthew.auld@intel.com, 
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
In-Reply-To: <20260313132103.2529746-46-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-46-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491461.6181.10410600947387909666.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=346;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=BZ9OnSZMjHtnBy8UMjGQ5P4rP4eQBOgbvGHCa8uMjxk=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjZxddlPCl1+/58HJgkL+0TsGWxatjLXA4vh
 IqI6KZs35qJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOKg7g/+JRrhl90D/DT44Ju7Vwke71c5FFg8GW6
 0sJqES018X3UNC0YltTGljJayaKOvsJo/qDdUhwR6JSI+YtE3u3Cw5doHY90JfquUMrdnJtW/Cf
 m9h5ZV9eCEDkvd68DwfTu/Lia7Cqy0E5jxNCTR3kSuXgcbpJoAxm0yaOH4QjXNBhIOgQcsuKXSO
 xbnzVsGnIwZDCAuK/za8t988MWyL6Uxf/W8ANPjwKFFSDaKjyur7U7qYSOWW0bLlBZ2CIWKD1Ww
 P7Wy/nvas3HynlgYL/7w17o6nZ9vT+AYddPUHT3KmAUA3Hkpkt677HfSA9CiIQeWedIU6IrGWQ2
 ZXRbbtnuGuhFAONII6OL9/3Gfjr96nNiUEFzs0qZdchR04b800F4l6sKPrniS0Hsqs9c41co6xV
 694vBuot0QTgXmbDd52seNVtOgQBdCqI5gSPwvxztfNivusJEwPOu4u6dOHRHgprQjkrCsaz3lE
 4i5dfBHGbhCJT9HgXWe1WZzt/BeNtdPLwVZb0Z6u+kN5dtcuHZzeyUpP2h/PdhBbMmD6Ukw2+cv
 Fow04PnvlBlj8HfReRmWs5dw8bREW4bSjxVSEwe051PySHs0q1z2KPe8GikuPzSUdef9FSlarvc
 aR0Q6g0UKn6BAmdSJdReUPxCr3Cr8CmgIwFMMtVvqJvQ6FoPR8gs=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
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

On Fri, 13 Mar 2026 07:20:10 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> virtio_gpu has 10 DRM_UT_CORE debugs, make them controllable when
> CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
> class'd debugs.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>

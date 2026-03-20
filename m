Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C4A10987A5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3301110EBF9;
	Fri, 20 Mar 2026 16:43:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="NHg1o9NM";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A62010EBF6
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:43:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1A7F81A2F04;
 Fri, 20 Mar 2026 16:43:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DDDD3600E0;
 Fri, 20 Mar 2026 16:43:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7A99810450CB4; Fri, 20 Mar 2026 17:43:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774025014; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=31ASMBAKkCZvbIzzChCZn5t+eyClecR9X8s5jtDmP5A=;
 b=NHg1o9NMEYO/YqP50q0DLf78w/7C9WTrG8BX3HhIMIhHA6xDR57nzHfd4yt8NGGRBZ79WF
 tfhQD9pK926vJjbA22OyePC9uSOSCoE32/StlzqwW4ntiMh4TiAF4qLRh+Gr617zqtzCRD
 ETSQxxgzZXTMEiH+XpdwQ1McYT1xeWLqJOmqRlVAaY61chGGSpc3CGYQGgSStA2RuICEuG
 bsQ6cwtScKqiYSAevCm8e5R6fglXauWceaf7BsxN4JByGKHVTDO/6a+e57IVq3S9ZblToV
 W6eqDCzH+zXh3TVpLQGQujbzXJ8Jgsg8ixtYeo1fdBgaZcgYr/AiuLqlJ442Pw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 58/65] accel: add -DDYNAMIC_DEBUG_MODULE to
 subdir-ccflags
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
In-Reply-To: <20260313132103.2529746-59-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-59-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491475.6181.8616252067426369904.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=801;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=X28ibDJAvuYjj7yiqUww7MeGkFuQWXoLEUYWDJtjJsg=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjbTOgnLMV490pkxQ5lFoXQ2Ia8lJTVcfSlB
 XYlncmO3fmJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOITthAAw6HTYJqumqo29pNJSwsbdr0yjd2bqSB
 ng1wMfJcbPGXE1S5bcKz9nFANQdA8zPbLQJWeW8Ptei3ymNmwq6ZYeQgPme6x9zpz1bNwGscTMo
 3Z5fcZaWnrDs1cqkr2s4D8LiBfWw6B2rmyl86war2CKsNRGQeTl+nNK4S7Rc5BhB/Zz9B9bE9q2
 cowda5yEYUjFEBnjQtUeC1ie8aLxagYgbl9l+BgJ361Vd+rqNyloDHv8ic8EHiwaxaa5V5IcgXT
 DX3B6WsFSWUN6Bm1FR/76RW8wj6spGansLDaXROOVikwJVNibKFlfl8FR3egAe5qs4nOlmmhPdq
 yqsiFCQHxkUWHmHrzWWsnDHmIOGOTAkYW39IL4sX7deCuL2Hn5Z+/V4kDR8cC1f2bw3+Xldknpi
 jAQaGWOyWrQm1f/mM8uF54txUaBB0TjBcsh8Ujxy/WcDQ6/M+LZAqfpvhmIx0LMI3wUZLOfc+RA
 kSDeC2LOuXWoMYMpvWAw+x8/kj9wLk7251M0CbFL5Wc66ZIk66YgjYmOVFcdkC2eL2l9dhbtnT5
 g/6vg2FMWBE+U8D/X4ciGxQ684Ew4uEsfedDGLgacHGc/XI2h1eK3se8o1N5lVxxVJLvh0G7OZy
 C0wYCgNMJp/xQoJXxhLQOzJTrDrQXfvQh0YjwDuzHVbricXs+h5o=
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

On Fri, 13 Mar 2026 07:20:23 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
> index 1d3a7251b950..44db786ea223 100644
> --- a/drivers/accel/Makefile
> +++ b/drivers/accel/Makefile
> @@ -1,8 +1,13 @@
> [ ... skip 9 lines ... ]
>  obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
> -obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
> \ No newline at end of file
> +obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/

This is an unrelated change, if you do a new iteration it could be nice to
remove the newline.

With or without this change:

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>

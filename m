Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12A606A324
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fFAikIxi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675A1112A35;
	Fri, 27 Nov 2026 11:03:48 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43FEC112A35
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:03:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E8638C2B9D2;
 Fri, 27 Nov 2026 11:03:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 355B16049C;
 Fri, 27 Nov 2026 11:03:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6887611E6823C; Fri, 27 Nov 2026 12:03:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795777415; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ujGqZTSxVHheVnhAWnyCqfkuc+NmQTu5Q4OQnR1Mlns=;
 b=fFAikIxisUL4oCPVNrWtPuiNNyy/uCtLg6UPUCysD6/osCz8YnbjAc0ZZzR0rWx6VG6zKM
 65CP1fj7dBHnSU6ps03rugTSJkTh6uGzYdpw2aJdQw7NI2r1vKeX5rrxaZNqTgtSypNMGl
 4ZByus2x2bIt6K/o5gO2srJlnjgmDMpDHFyKXxEBMwJu6kJj2XM1EtWy8dxsnVJpGVFAJ5
 d2bOhz7HdtU8NSScXPwB3rOogCVkAEn2yob7uYl9RPxqZY6s9CX8csTZip7nwuygfiwtK+
 NMde57ionp0vEbYY94nvRSjIZW9WX2ZmjSnGJqvZeL4DaZJuIiYORpQkrVERVQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 12:03:30 +0100
Message-Id: <DN5XYPFHYKJA.3OY1DVYSDPGQW@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] MAINTAINERS: Add Luca Ceresoli as bridge maintainer
Cc: "Simona Vetter" <simona.vetter@ffwll.ch>, "David Airlie"
 <airlied@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Dmitry Baryshkov" <lumag@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Robert Foss" <rfoss@kernel.org>,
 <dri-devel@lists.freedesktop.org>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>
To: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>, "Maxime Ripard"
 <mripard@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261119133533.520180-1-mripard@kernel.org>
 <20261119134455.GB2243298@killaraus.ideasonboard.com>
In-Reply-To: <20261119134455.GB2243298@killaraus.ideasonboard.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Maxime, Laurent,

On Thu Nov 19, 2026 at 2:44 PM CET, Laurent Pinchart wrote:
> On Thu, Nov 19, 2026 at 02:35:33PM +0100, Maxime Ripard wrote:
>> Luca has been one of the most active reviewers of the DRM bridge
>> subsystem without having the maintainer status.
>>
>> Add him as a maintainer to match the current situation.
>>
>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Thank you Luca.

No problem, good ot know I'm helpful. :)

Acked-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

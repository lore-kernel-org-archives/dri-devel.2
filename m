Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D7DC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC1F810ECAC;
	Tue,  1 Sep 2026 12:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="V0g1+T8V";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF1410ECAC
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788265863;
 bh=0cjXppRhGX/DMTcgLpKy2KbGeSyz7F8K0A7pf9RNNXo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=V0g1+T8Vt3HbVt4yi9ANc9vKwMuo0BUmfh2mtEchb7jVibPVqYwQB9qB+4D2ty0Zi
 Iv1r4xHV4cgL/RdTqu39EULdXqu26oF/huV9mvBo91+K8EoaEY7dkElEjYY1CAnxW+
 cspGHoewcQnA0RZ2gURuB6vMuy3q7dXg8pKUahEcw4scRnv0XnAO0+oexiVPFf48DM
 RWb4vqEWI3zf5jZKXfn6KRrI3IMcQy251GJL2vCcwezY78KXIyA75am9DlgwZbqrx0
 q3DF/lfLAi+1VaAanSq5YaDC/My2phFby/lO18kG2l2sU1j1ELokZivmy6gd0SJxn/
 aFhiF70ZfIcQw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 95ABA17E006A;
 Tue, 01 Sep 2026 14:31:02 +0200 (CEST)
Date: Tue, 1 Sep 2026 14:30:57 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 04/17] drm/panfrost: Move debugfs initialisation to
 relevant subsystems
Message-ID: <20260901143057.47497b30@fedora-21.home>
In-Reply-To: <20260828-claude-fixes-v7-4-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-4-72a13b2c125d@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 28 Aug 2026 21:56:44 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> @@ -757,4 +758,28 @@ void panfrost_gem_debugfs_print_bos(struct panfrost_=
device *pfdev,
>  	seq_printf(m, "Total size: %zd, Total resident: %zd, Total reclaimable:=
 %zd\n",
>  		   totals.size, totals.resident, totals.reclaimable);
>  }
> +
> +static int panfrost_gems_show(struct seq_file *m, void *data)
> +{
> +	struct drm_info_node *node =3D m->private;
> +	struct panfrost_device *pfdev =3D to_panfrost_device(node->minor->dev);
> +
> +	panfrost_gem_debugfs_print_bos(pfdev, m);
> +
> +	return 0;
> +}
> +
> +static struct drm_info_list panfrost_debugfs_list[] =3D {
> +	{"gems",
> +	 panfrost_gems_show, 0, NULL},
> +};
> +
> +int panfrost_gems_debugfs_init(struct drm_minor *minor)


nit: I would rename that one panfrost_gem_debugfs_init().

The rest looks good

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> +{
> +	drm_debugfs_create_files(panfrost_debugfs_list,
> +				 ARRAY_SIZE(panfrost_debugfs_list),
> +				 minor->debugfs_root, minor);
> +
> +	return 0;
> +}

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AB6606A324
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x9SG0KUH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9045810E448;
	Fri, 27 Nov 2026 07:15:23 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF00C10E448
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 07:15:17 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso5668825f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 23:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795763716; x=1796368516; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wSJgjK+A00lNH/iVraNbWq5SwVJ5+VOU0GV4DugumqU=;
 b=x9SG0KUH3e1X2IZ3e9grGjmfHjEd9bxTRL17UNXi0Gke6La2Gnxq6Yb0Bvp+Bos/kN
 4gAzBKPSQR89SGUQKKL78t1ue/YdpqSb6lU86z3SQ0Y6ULiOv+1QbuLfTx8PQCaBVCZH
 KiIAPJAJ0gswnvLVvHXdSZ8YuLtxgBimXxnsEnEMOy0rVa3r0YyT/5O27xmVjMVPMS3z
 Fx4wp1wV5ZhTE+w7WFEEmATGShWD4ie6Lu2YjjiPyo66iJt0o87bB+VjxtvqJZRsGgX7
 AYp3p1dtkGHBN2OTQ/0uLcnO13AtKL7A5+yY6xsIRsp3dSIxOLCcscumuT2QMgpwXuEC
 oDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795763716; x=1796368516;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wSJgjK+A00lNH/iVraNbWq5SwVJ5+VOU0GV4DugumqU=;
 b=Di/MmRK8wqfvQ6K+loYBN7mJRvQ0GE7WvzqSuiWYK/uJximWYjjj53dd9+RmueN82u
 /7nKziYuOps2O34hu5cr3OnwUT4P4KEtsOa+e1JDoUollX14igLKr/iukkxw+almjPgV
 MwNeCkCZ0JRsaHk+1QMJSAcyc9fDuCXfUsocKuuM5qtzf/BEB81+26q34WZ0j9r47gQi
 kumucUmxBgyLu8unV5R85CcalZTtsfJVgcQd+FqrJUx9fDxXwt6xrZpEctfSQPIkBHhT
 ej4JQWP94VVdkLIktB11+CSP/VbVsyB5D5arnpthmR9c/irRfwKFZelZyN8MphYxCEnw
 B9vw==
X-Forwarded-Encrypted: i=1;
 AL+hErE+GVtPua+A67iJeoFPuwEZEtBRhevUmYH6kLLxuyvSiDackNHVcJz1ADecN9//p9POqxLQ0baA91A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+F+0Hn8/1b9MVUTDJBcJCeQwvHbuSUeWpR2Qdb+SawMn7SEC/0
 ENljjvBKLUjd6F0uquW8DBPwFAZc1wWcqSR1Adh7YcK428DTj0RwC2nH
X-Gm-Gg: AZFdTZdgBrGueWqgFA+WlZmNdUdHi9HReVfYNE02M+Xe9x9WbtCu3aMWvvGLhkISq+o
 UJL+YQb8dLrlEFJgeA7Om4TpQRe95CkEC6no119UWOEKGsAcSrUy5jQ/lBAOQA7QNg5Mdd2PNV9
 wmxJolm4fFQjzBzUn2MzYDF0cMXA6sTs2IdX9jOgQSGs9dKo61ApjunjcOll8Q9v+cgXxD6eRFD
 +kNfhV7dVxmovR5kGDg+6DYSeHNrxwRJg51D614/jv6eMAy7iqq1Azwi6Wx9jeNbceK5e73fppp
 hCON+WzUT/zk+hSITchZRJ82EitApyPwSn/SP3T7WaLb3YsqSug/38cBwMFJ/qPn5K4cPVR2+PJ
 twV/MqqNMsAqccxKdGYFx6wulcpedgLGcz3TGImfDZGA0a+0XkPZuEh1cbxG0qrS2NpYYuG/GeE
 MFDvMNFHWrbPyJP93RSEhLZgQC9wqYXD9hJuAWRBLxQ7C78I2KS6ZRPeXpuAb8RnLIY8YM0pcB8
 RhIpZgNZVjMoboLy33OyqViWqdWjuWfHs3dYSfACKB0tMaNwT0aTD9aZdqsHtaJFukfEQIVzoXb
 hDv+caqPogOXGMxt2wm6c5VQXo9iopM=
X-Received: by 2002:a05:6000:2506:b0:48d:ba3b:af36 with SMTP id
 ffacd0b85a97d-4abb47b0f64mr55547662f8f.37.1795763715954; 
 Thu, 26 Nov 2026 23:15:15 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c50sm44603961f8f.37.2026.11.26.23.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 23:15:15 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 jose.exposito89@gmail.com, Jonathan Corbet <corbet@lwn.net>,
 Harry Wentland <harry.wentland@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com,
 victoria@system76.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v7 31/43] drm/vkms: Introduce connector type
Date: Fri, 27 Nov 2026 08:15:03 +0100
Message-ID: <awkt6PBpmDa69llM@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126-vkms-all-config-v7-31-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-31-21194cda2468@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 12:29:14PM +0100, Louis Chauvet wrote:
> In order to emulate connector-specific behavior, add the connector type
> to the connector configuration.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/tests/vkms_config_test.c |  5 +++++
>  drivers/gpu/drm/vkms/vkms_config.c            |  3 +++
>  drivers/gpu/drm/vkms/vkms_config.h            | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_connector.c         |  2 +-
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> index a43dff511fc3..257ba0342034 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> @@ -137,6 +137,7 @@ static void vkms_config_test_default_config(struct kunit *test)
>  	struct vkms_config *config;
>  	struct vkms_config_plane *plane_cfg;
>  	struct vkms_config_crtc *crtc_cfg;
> +	struct vkms_config_connector *connector_cfg;
>  	int n_primaries = 0;
>  	int n_cursors = 0;
>  	int n_overlays = 0;
> @@ -211,6 +212,10 @@ static void vkms_config_test_default_config(struct kunit *test)
>  
>  	/* Connectors */
>  	KUNIT_EXPECT_EQ(test, vkms_config_get_num_connectors(config), 1);
> +	vkms_config_for_each_connector(config, connector_cfg) {
> +		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_type(connector_cfg),
> +				DRM_MODE_CONNECTOR_VIRTUAL);
> +	}
>  
>  	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 342b844bfc6d..b415d4bf6edb 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -647,6 +647,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  			seq_puts(m, "connector:\n");
>  			seq_printf(m, "\tstatus=%s\n",
>  				   drm_get_connector_status_name(vkms_config_connector_get_status(connector_cfg)));
> +			seq_printf(m, "\ttype=%s\n",
> +				   drm_get_connector_type_name(vkms_config_connector_get_type(connector_cfg)));
>  		}
>  	}
>  
> @@ -1005,6 +1007,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
>  
>  	connector_cfg->config = config;
>  	connector_cfg->status = connector_status_connected;
> +	vkms_config_connector_set_type(connector_cfg, DRM_MODE_CONNECTOR_VIRTUAL);
>  	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
>  	/* refcnt starts at 1: this reference is owned by config->connectors */
>  	kref_init(&connector_cfg->refcnt);
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index eb29008e54f0..efebb190ce40 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -150,6 +150,7 @@ struct vkms_config_encoder {
>   *
>   * @link: Link to the others connector in vkms_config
>   * @rcu: RCU head for deferred freeing of this object
> + * @type: Store the type of connector using DRM_MODE_CONNECTOR_* values
>   * @config: The vkms_config this connector belongs to
>   * @status: Status (connected, disconnected...) of the connector
>   * @possible_encoders: Array of encoders that can be used with this connector
> @@ -167,6 +168,7 @@ struct vkms_config_connector {
>  	struct rcu_head rcu;
>  	struct vkms_config *config;
>  
> +	int type;
>  	enum drm_connector_status status;
>  	struct xarray possible_encoders;
>  	bool unlinked;
> @@ -397,6 +399,28 @@ vkms_config_plane_set_default_pipeline(struct vkms_config_plane *plane_cfg,
>  }
>  
>  /**
> + * vkms_config_connector_get_type() - Return the connector type
> + * @connector_cfg: Connector to get the type from
> + */
> +static inline int
> +vkms_config_connector_get_type(const struct vkms_config_connector *connector_cfg)
> +{
> +	return connector_cfg->type;
> +}
> +
> +/**
> + * vkms_config_connector_set_type() - Set the connector type
> + * @connector_cfg: Connector to set the type to
> + * @type: New connector type
> + */
> +static inline void
> +vkms_config_connector_set_type(struct vkms_config_connector *connector_cfg,
> +			       int type)
> +{
> +	connector_cfg->type = type;
> +}
> +
> +/*
>   * vkms_config_plane_get_default_rotation() - Get the default rotation for a plane
>   * @plane_cfg: Plane to get the default rotation from
>   *
> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
> index bb023b5af4e4..84c49915ed44 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -89,7 +89,7 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
>  		return ERR_PTR(-ENOMEM);
>  
>  	ret = drmm_connector_init(dev, &connector->base, &vkms_connector_funcs,
> -				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
> +				  vkms_config_connector_get_type(connector_cfg), NULL);
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> 
> -- 
> 2.56.0
> 

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>

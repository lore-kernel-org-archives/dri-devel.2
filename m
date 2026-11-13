Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB083606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bk1hFXNu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A62E10E747;
	Fri, 13 Nov 2026 01:34:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99AF210EBDD
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794533643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HX8JDnkQUSdkQL8lAJ2VgGCKAUpOjghvCUmklLZFFl8=;
 b=bk1hFXNuDdsq6HK7FCEGF3YEbkyaChMVrry2FLKk527jkIno/Zr1UYkBhThiHo0A7K4/ag
 tDcPRwAEL2zBzZzOL7m2vZSzT4XRVXsEKA6IB9mCZV+uqDk8Yxw10cvMTdoFhUPKBJ/eaJ
 S5suhhG20085Ws2rvzOw29mkbf85EFA=
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-w53XmFtaP9eZW4bAqF0fzQ-1; Thu, 12 Nov 2026 20:34:02 -0500
X-MC-Unique: w53XmFtaP9eZW4bAqF0fzQ-1
X-Mimecast-MFC-AGG-ID: w53XmFtaP9eZW4bAqF0fzQ_1794533641
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b238436265so207193c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794533641; x=1795138441;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HX8JDnkQUSdkQL8lAJ2VgGCKAUpOjghvCUmklLZFFl8=;
 b=fc655UvS4hMHQGGaGL9J2zFtrFgWBW3kbOl9zBVpolknaThNxVxSV7ckekmw9+/7KA
 YUZZgTv9T73Jn7/phTSk4NkyGGpVpCDeutVeNwruc3V9pQkWHTp+lPwPI2M4iyJsUByT
 P8z6A4A3MedZHWYgLRfJkKqskRyJuRH+E1q25cZ8oOf7s22jFMLqzANvGD9aZT7sawh8
 qdpzG9j4hIQ22UyY2f8K0dZx3KTfq/ef584WOm3MSO42NKoIjOdCyiEOvawrTMTSVL1R
 HQUcq1HKQ1PoSQnyvgcx+oFQLG3CKLcVErH9kfKKRdE+Nb3eFp815OnoFmJFRmZQb6fl
 7MNQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFmDBiEpuQDDOEDuavWPoci71+J3zlVSnLhIDDluD/MwL4cq8mj0iGb3HV3w4v7Cwh013s4cS/QYYc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+7lM0rRGpVR9Pl6mTxPM2NLlOHqs+OeaS1jznQ4SOC1Erj6gJj
 P2qJnZJr6eM1LXBlsuJADBxUrh7ES+g/JqZpxhNgvus4qWb7bXESgl0xj5L7ZR7tjgiQyYeBIZi
 bMwO+KULNs/jhH17jWBUNd5ZYAuh6AxwNk+V6HMcJ8l/EutBukqmS+iZSZcFI7XZ0jh0x3WtgLI
 u7sRH/Ff9r7XiNt+BlRUt2hn3J3+gcgqYMMZq1AIeTsi9+NihDoTpIVg0=
X-Gm-Gg: AYBFou1CuClUR00BJtteJQkX5fyC5OXrWwxH7ekBJMkAGmAZU7j4YfvZsbgpGT0hXmd
 GQQm62piV25bOsHeI7HxVrfKjTyw0HLy5goJMaJC/m/1csRI5ClEKO0cnrWeI/eTRnzigv5/8fY
 sJVfd+sdUjc6JSNizoevua8ehS3Fy8xJALda+cJyZ/bQjqI00wqpEGp7tzWtIK5a3wSyNbvUG+j
 6VRSdpV4ASHbOQI
X-Received: by 2002:a05:701b:2402:b0:1ab:faad:cba with SMTP id
 a92af1059eb24-1b5030eb09amr1041179c88.34.1794533640708; 
 Thu, 12 Nov 2026 17:34:00 -0800 (PST)
X-Received: by 2002:a05:701b:2402:b0:1ab:faad:cba with SMTP id
 a92af1059eb24-1b5030eb09amr1041154c88.34.1794533640114; Thu, 12 Nov 2026
 17:34:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
 <20261112-amdgpu-dc-cleanup-v1-19-0fae41718ad2@redhat.com>
 <3179d0b2-cbfa-4f09-9e24-363210718fb3@amd.com>
In-Reply-To: <3179d0b2-cbfa-4f09-9e24-363210718fb3@amd.com>
From: David Airlie <airlied@redhat.com>
Date: Fri, 13 Nov 2026 11:33:48 +1000
X-Gm-Features: AclHuK_fCZvVs1RRnIhZagWHLsy677KbRvHKcoOFh-cTgRp7mq9zzbruL6lO4nM
Message-ID: <CAMwc25rDq6biXokgwZJNbRfA3KZzZ1x3KxU=CPe7HvnS_PN3+w@mail.gmail.com>
Subject: Re: [PATCH 19/19] drm/amd/display: Replace dc_get_caps with
 purpose-built capability queries
To: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Austin Zheng <austin.zheng@amd.com>,
 Jun Lei <jun.lei@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AfmdMh5TunC6TOVIcoLFXkxbsfEFHpkqC7r_usrIFNQ_1794533641
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 5:42=E2=80=AFAM Harry Wentland <harry.wentland@amd.=
com> wrote:
>
> On 11/11/26 20:43, Dave Airlie via B4 Relay wrote:
> > From: Dave Airlie <airlied@redhat.com>
> >
> > Split the caps view accessor into per-capability queries so DM and the
> > DAL modules no longer read through struct dc_caps:
> >
> > - scalar getters for is_apu, ips/dmcub support, max links/streams/
> >   planes/slave planes/cursor size/v_total, vtotal_limited_by_fp2,
> >   i2c speed, PCON/DSC/fused-io support, SubVP processing delay and
> >   MALL size
> > - dc_dmub_supports_psr()/dc_dmub_supports_aux_backlight() for the
> >   DMUB capability bits
> > - dc_get_color_caps() copies out the color pipeline capabilities
> > - dc_get_plane_caps() returns the static plane capability array
> >
> > The KUnit tests keep installing fake capabilities through the
> > dc_test_caps() view of their own fake DC.
> >
> > No production code outside the dc directory reads struct dc members
> > through a caps view anymore.
> >
> > Part of making the struct dc sub-structures opaque outside DC.
> >
> > Signed-off-by: Dave Airlie <airlied@redhat.com>
> > ---
>
> <snip>
>
> >
> >  unsigned int dc_get_disable_ips(const struct dc *dc)
> > diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc.h b/drivers/gpu/drm/=
amd/display/dc/inc/dc.h
> > index 31baba820f6c..7a49f2ee1d77 100644
> > --- a/drivers/gpu/drm/amd/display/dc/inc/dc.h
> > +++ b/drivers/gpu/drm/amd/display/dc/inc/dc.h
> > @@ -2351,8 +2351,38 @@ struct dc_context *dc_get_ctx(const struct dc *d=
c);
> >  /* The ASIC display engine version. */
> >  enum dce_version dc_get_dce_version(const struct dc *dc);
> >
> > -/* Capabilities detected at dc_create() time. Read-only. */
> > -const struct dc_caps *dc_get_caps(const struct dc *dc);
> > +/*
> > + * Capabilities detected at dc_create() time. Read-only; prefer the
> > + * purpose-built queries below over reaching into the caps structure.
> > + */
> > +bool dc_is_apu(const struct dc *dc);
> > +bool dc_get_ips_support(const struct dc *dc);
> > +bool dc_get_dmcub_support(const struct dc *dc);
> > +unsigned int dc_get_max_links(const struct dc *dc);
> > +unsigned int dc_get_max_streams(const struct dc *dc);
> > +unsigned int dc_get_max_planes(const struct dc *dc);
> > +unsigned int dc_get_max_slave_planes(const struct dc *dc);
> > +unsigned int dc_get_max_cursor_size(const struct dc *dc);
> > +unsigned int dc_get_max_v_total(const struct dc *dc);
> > +bool dc_get_vtotal_limited_by_fp2(const struct dc *dc);
> > +unsigned int dc_get_i2c_speed_in_khz(const struct dc *dc);
> > +bool dc_get_dp_hdmi21_pcon_support(const struct dc *dc);
> > +bool dc_get_edp_dsc_support(const struct dc *dc);
> > +bool dc_get_fused_io_support(const struct dc *dc);
> > +unsigned int dc_get_subvp_fw_processing_delay_us(const struct dc *dc);
> > +unsigned int dc_get_mall_size_total(const struct dc *dc);
> > +bool dc_dmub_supports_psr(const struct dc *dc);
> > +bool dc_dmub_supports_aux_backlight(const struct dc *dc);
> > +
> > +/* Copy out the color pipeline capabilities. */
> > +void dc_get_color_caps(const struct dc *dc, struct dc_color_caps *caps=
);
> > +
> > +/*
> > + * Return the static plane capability array and its entry count.
> > + * Valid until the DC is destroyed.
> > + */
> > +const struct dc_plane_cap *dc_get_plane_caps(const struct dc *dc,
> > +             unsigned int *count);
> >
>
> This creates some API bloat.
>
> What about creating a new public struct header and throwing dc_caps
> (or a subset of it) in there?
>
> The intent to decouple how DC stores and reports caps is valid.

Yes I think it's probably a good idea, the last couple of patches were
definitely pushing the limits of where I wanted to go, dc_caps is at
least a reasonably self contained if not a bit haphazard.

Dave.


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D0606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=f61ap+t/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6E910F892;
	Tue, 17 Nov 2026 19:12:50 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0219C10E658
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:12:44 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-717080a2d50so160464eaf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 11:12:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794942764; cv=none;
 d=google.com; s=arc-20260327;
 b=nQqcEB0nbPnC3GojfgbnJjGZncy2JkaLpuyxnn3Ywv9gokTB3RaCN+fxbYxQyZS3t8
 1r53Ic1qblfHmu832DESBiYnyb2YxeYYrER7zZ7uTdrakEnO8YX8uknoHzojwnUYAwi0
 MN1CS+7b+DRihqe1ji+qq1Wph7JSS3M2raTFlr2HQKPb4oTHiAxca1iXkgg99vis709l
 2cXkQoZ6mcMSz8W6jXOPMYHb61kKrjG93CKfUJkXpKLD8oYbsThliunnyhxP75tsuDhu
 v1ClsMVAVcdD8Qi3Gb0uEu5HXfFLUTkWjc/VekVL6n98uudjuwXyRRhcbNxEFZ6NgKL+
 cYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kYPA8tarVAEw5Z9vFPCpKVSX5tG6DYwzNUtP3jq7kk4=;
 fh=Ot0hICSwdkSDnz9EfJZesRajefBoGCNsssF+tLG/eCM=;
 b=p2fGm6vzN8s/JXpkgrbs/xwmwaCtpn2E4aBh1pSii6BMvYPz7QkwTCoG5GiWY3Kxdn
 XPIYYf0f1KpAcMcjK3Qa+6aOevh7XYXFIg+nAVBbydITibTcr3MVwFGFX1XfgwSXvSw6
 qcnd8cJcxgU0fGPxKg52a4YBmmPj/skFoAhckCcQLwMfCHWkynU9aPE3aaFQAyKA4Cb4
 mu1v+stRQhGL2dq4aaitQIVPpwxjSP8Q4ZfTq+ZP2W9me5GvQeYDnHJSjVxZoCrH/1vF
 /uqIu4DdP3hRd/04mLIEj5awarFry/e4nmHNNALclQTPw4i2mZcM1uMwHI/K95Tkq8IL
 tHpw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1794942764; x=1795547564;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kYPA8tarVAEw5Z9vFPCpKVSX5tG6DYwzNUtP3jq7kk4=;
 b=f61ap+t/b4VRRU3zr34jzV8XiZB5uDf5eB51AYFydtGwcrHIrNOLE86EfjkNJq/9Hv
 TBRUSd9+YR5NC8+V4qctKGZF2agJP8rQkLArYLNyjOSbrFX+Di7joK6FuRjg4CyzzUb0
 bHhPAaGfkNlblrlLNcZRTXd4YZ8i4fjXFtl14wP/OeygXCvDqSnQgjfwIsvL5eRQ+7vZ
 geGYOK7lJ10OjVSeMU0BvMLEC1IQ5OtTqUOdiLkhlGNenJ2zGBed9GMOG/aqfO+ZJBLp
 s1X5fRfz/3G8+4CdS7NslD6KQIeuPiYMdGJVXQv0B2CFFcAZZGFuRqJEo9KAbMtcsYQE
 zJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794942764; x=1795547564;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kYPA8tarVAEw5Z9vFPCpKVSX5tG6DYwzNUtP3jq7kk4=;
 b=BMzkjwfG9QDjRHzXs7cLv6A8bO2b41cmyLlcxzH0BsVLFbixxADYw5EgFlmAcOd374
 lt8O5HkNc8KUWVfHNciZF2T8TD5dpeYSnMjOHkyyD8kfGqxdwNvpy0cUbKqhKqbzOWzz
 pArCPt+N3zNRQAQtSu/oXMIFeKrQyT6p/QinJ0SvKASdp4a2tEJ4TAjpEmDz3esao2mv
 MPvbuooxyj3PwaaDnbT0X3MPSKSYwwIluaT0zm/bcIsot/cGInIA7Xx+OSbQ11SRMJcA
 +TJ+Lazk4FtgKr+ghxAl8MfoHGCNLJE14v6FcAwFJXUMVq29LwNVAuRXF2NSgwnpDO1v
 z9Xw==
X-Forwarded-Encrypted: i=1;
 AL+hErEIdX85BLE7Z6ipqFNexV2gY/fFc2cGuv49OiLmcJDUHITVbT4oEGK+0wdelF2/Qkcfk/ZHIVCUPiA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8kvPV05PUl0leqchhnWokgQlMxWnqFnOAbnmMqdACoLPBqKIDc
 qOpjArS8bN59GGErT7qWKtwoI9B72sqnAfw+hpScIGAGnHW0orqgHHZU/GJq7j59YoAqLuzzeW3
 XGix14qcQDJswQGMXiYdtlyfFfFlKQOeXaL1IB7NzuA==
X-Gm-Gg: AYBFou1bhptQe2Jy5hYVpe1a8MHE0ZaRTNJWPuN5ZOSgXHEawHdpkGN0+93UD8SVAbr
 e0RVBwE/m+TlYkkl6iqcbDGMp7lR1h1M6gwjXLZ2uBvcI5EbaEP6b6cpikCzGuwHzgnK1ogMUwD
 fGOmRSBq4RU2ygXv0jW7CqjVOkWPR8WRqcW3hZkVnEWXeymdOIjDX12hX9uCYhUdPyx/UPcvz/n
 5rtMEGJPJyQuXk3xbXd96zKaAuUlXeXkX+CBksgsT+kC8EyTA/UKJfDYOuxluV5DcqCVD5bz7KT
 wMtghR2BRSZtH3WEouUWkTjSVmGXMwWLh3Sn1ewVQ0DQD+z0vtiJaqGhqd0wt99uIvEyC31g1Vl
 sF8+mv9lBqY5m1dq1tLEyr/gaDtCyOtKyGUgIPHJtWi6Z1Ux2BuM98yvukhTdKkdjJgzeNC9pK6
 8892lOYiXwmZx5ZDKH9uD5A/G6/yBueVrlEqbr6190LHicssfadD6LzQ==
X-Received: by 2002:a05:6820:55d5:20b0:71a:fb4b:a988 with SMTP id
 006d021491bc7-71b184ed86emr177842eaf.47.1794942763873; Tue, 17 Nov 2026
 11:12:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-drm-reset-state-flag-v11-0-378b3f7bef32@kernel.org>
 <20261116-drm-reset-state-flag-v11-6-378b3f7bef32@kernel.org>
In-Reply-To: <20261116-drm-reset-state-flag-v11-6-378b3f7bef32@kernel.org>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 17 Nov 2026 19:12:27 +0000
X-Gm-Features: Aa3M54rMdloF5GPfjbPDu5yqWWdIpGB-WDV67sxUG3_26RmcuUfnvJjLKvmFoZI
Message-ID: <CAPY8ntCyverGKsrzGVAnSeVokVFF4wxBVvuj1Cx178GctPtWwQ@mail.gmail.com>
Subject: Re: [PATCH v11 6/9] drm/vc4: Carry the HVS channel over to created
 CRTC states
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 =?UTF-8?B?Sm9uYXMgw4VkYWhs?= <jadahl@redhat.com>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, 
 Simon Ser <contact@emersion.fr>, Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 at 10:17, Maxime Ripard <mripard@kernel.org> wrote:
>
> drm_atomic_commit_fill_with_defaults() builds its commits out of
> states created through atomic_create_state() instead of duplicating
> the current state. A created CRTC state comes with its
> assigned_channel left to VC4_HVS_CHANNEL_DISABLED, while a duplicated
> state carries the channel currently in use.
>
> vc4_pv_muxing_atomic_check() skips the CRTCs whose enablement doesn't
> change, so a CRTC that stays enabled with a created state keeps its
> channel unset, and vc4_core_clock_atomic_check() then indexes
> hvs_new_state->fifo_state[] with VC4_HVS_CHANNEL_DISABLED (-1U), far
> outside of the array.
>
> Copy the channel of the current state over in the skip branch, like a
> duplicated state would have carried it. This is a no-op for duplicated
> states, which already have the channel set.
>
> Add a KUnit test that enables an output, fills a state with defaults
> and re-applies the same configuration, and checks that the CRTC kept
> its channel.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

>
> ---
>
> To: Dave Stevenson <dave.stevenson@raspberrypi.com>
> To: Ma=C3=ADra Canal <mcanal@igalia.com>
> Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> ---
>  drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c | 105 +++++++++++++++++++=
++++++
>  drivers/gpu/drm/vc4/vc4_kms.c                  |  16 +++-
>  2 files changed, 119 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu=
/drm/vc4/tests/vc4_test_pv_muxing.c
> index 7a54f46acff9..c868d2cd1b3d 100644
> --- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
> +++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
> @@ -1119,14 +1119,119 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enab=
le_too_many_crtc_state(struct ku
>
>         drm_modeset_drop_locks(&ctx);
>         drm_modeset_acquire_fini(&ctx);
>  }
>
> +/*
> + * Test that a CRTC that stays enabled with a state created through
> + * atomic_create_state(), like the ones drm_atomic_commit_fill_with_defa=
ults()
> + * builds for a reset, keeps the HVS channel it was assigned:
> + * vc4_pv_muxing_atomic_check() skips the CRTCs whose enablement doesn't
> + * change, so their new state has to carry the channel over from the
> + * current state, the way a duplicated state would, for
> + * vc4_core_clock_atomic_check() to see a valid channel.
> + */
> +static void
> +drm_test_vc5_pv_muxing_bugs_created_state_keeps_channel(struct kunit *te=
st)
> +{
> +       struct drm_modeset_acquire_ctx ctx;
> +       struct drm_atomic_commit *state;
> +       struct vc4_crtc_state *new_vc4_crtc_state;
> +       struct drm_device *drm;
> +       struct vc4_dev *vc4;
> +       unsigned int old_channel;
> +       int ret;
> +
> +       vc4 =3D vc5_mock_device(test);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
> +
> +       drm_modeset_acquire_init(&ctx, 0);
> +
> +       drm =3D &vc4->base;
> +retry_first:
> +       state =3D drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
> +
> +       ret =3D vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_=
HDMI0);
> +       if (ret =3D=3D -EDEADLK) {
> +               drm_atomic_commit_clear(state);
> +               ret =3D drm_modeset_backoff(&ctx);
> +               if (!ret)
> +                       goto retry_first;
> +       }
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       ret =3D drm_atomic_check_only(state);
> +       if (ret =3D=3D -EDEADLK) {
> +               drm_atomic_commit_clear(state);
> +               ret =3D drm_modeset_backoff(&ctx);
> +               if (!ret)
> +                       goto retry_first;
> +       }
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       new_vc4_crtc_state =3D get_vc4_crtc_state_for_encoder(test, state=
,
> +                                                           VC4_ENCODER_T=
YPE_HDMI0);
> +       KUNIT_ASSERT_NOT_NULL(test, new_vc4_crtc_state);
> +
> +       old_channel =3D new_vc4_crtc_state->assigned_channel;
> +       KUNIT_ASSERT_NE(test, old_channel, VC4_HVS_CHANNEL_DISABLED);
> +
> +       /* Make the enabled state the current one */
> +       ret =3D drm_atomic_helper_swap_state(state, false);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +retry_second:
> +       state =3D drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
> +
> +       /*
> +        * Fill the state with defaults, like a DRM_MODE_ATOMIC_RESET
> +        * commit would, then re-apply the exact same configuration.
> +        */
> +       ret =3D drm_atomic_commit_fill_with_defaults(NULL, state);
> +       if (ret =3D=3D -EDEADLK) {
> +               drm_atomic_commit_clear(state);
> +               ret =3D drm_modeset_backoff(&ctx);
> +               if (!ret)
> +                       goto retry_second;
> +       }
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       ret =3D vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_=
HDMI0);
> +       if (ret =3D=3D -EDEADLK) {
> +               drm_atomic_commit_clear(state);
> +               ret =3D drm_modeset_backoff(&ctx);
> +               if (!ret)
> +                       goto retry_second;
> +       }
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       ret =3D drm_atomic_check_only(state);
> +       if (ret =3D=3D -EDEADLK) {
> +               drm_atomic_commit_clear(state);
> +               ret =3D drm_modeset_backoff(&ctx);
> +               if (!ret)
> +                       goto retry_second;
> +       }
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       new_vc4_crtc_state =3D get_vc4_crtc_state_for_encoder(test, state=
,
> +                                                           VC4_ENCODER_T=
YPE_HDMI0);
> +       KUNIT_ASSERT_NOT_NULL(test, new_vc4_crtc_state);
> +
> +       KUNIT_EXPECT_EQ(test, new_vc4_crtc_state->assigned_channel, old_c=
hannel);
> +
> +       drm_modeset_drop_locks(&ctx);
> +       drm_modeset_acquire_fini(&ctx);
> +}
> +
>  static struct kunit_case vc5_pv_muxing_bugs_tests[] =3D {
>         KUNIT_CASE(drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable),
>         KUNIT_CASE(drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too=
_many_crtc_state),
>         KUNIT_CASE(drm_test_vc5_pv_muxing_bugs_stable_fifo),
> +       KUNIT_CASE(drm_test_vc5_pv_muxing_bugs_created_state_keeps_channe=
l),
>         {}
>  };
>
>  static struct kunit_suite vc5_pv_muxing_bugs_test_suite =3D {
>         .name =3D "vc5-pv-muxing-bugs",
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.=
c
> index ab551eb2da50..562f2d1f45a4 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -970,15 +970,27 @@ static int vc4_pv_muxing_atomic_check(struct drm_de=
vice *dev,
>
>                 drm_dbg(dev, "%s: Trying to find a channel.\n", crtc->nam=
e);
>
>                 /* Nothing to do here, let's skip it */
>                 if (old_crtc_state->enable =3D=3D new_crtc_state->enable)=
 {
> -                       if (new_crtc_state->enable)
> +                       /*
> +                        * A CRTC that stays enabled keeps its channel. A
> +                        * duplicated state carries it over, but a state
> +                        * created through atomic_create_state() comes wi=
th
> +                        * the channel unset, so copy it from the current
> +                        * state to make sure the core clock check and th=
e
> +                        * commit see the channel in use.
> +                        */
> +                       if (new_crtc_state->enable) {
> +                               new_vc4_crtc_state->assigned_channel =3D
> +                                       old_vc4_crtc_state->assigned_chan=
nel;
> +
>                                 drm_dbg(dev, "%s: Already enabled, reusin=
g channel %d.\n",
>                                         crtc->name, new_vc4_crtc_state->a=
ssigned_channel);
> -                       else
> +                       } else {
>                                 drm_dbg(dev, "%s: Disabled, ignoring.\n",=
 crtc->name);
> +                       }
>
>                         continue;
>                 }
>
>                 /* Muxing will need to be modified, mark it as such */
>
> --
> 2.56.1
>

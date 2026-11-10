Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3CF60A260A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=CgV8TBAL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6A510E33C;
	Tue, 10 Nov 2026 20:59:48 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id D1EC810E33C;
 Tue, 10 Nov 2026 20:59:42 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id D469A20B7169; Tue, 10 Nov 2026 12:59:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D469A20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794344379;
 bh=hqEoXUSKFKGUg4QQgsXBLzMoojP6WQd1py1huwZKVyM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CgV8TBALRe9PmD4BW9hQlDbLI6nY1UF7MLw/zlWsYa0lYfP8nPVNw7/jTQdw3zyF/
 qMf34L7kUupiyUn3jiB93NtuLb66NFIIB534lqZ99YvFe730bnpmPhYMG56JV15PlU
 WrhlGgwIVY1VmbTtvEIX1EOi7pTFbBOmh37iueFQ=
Date: Tue, 10 Nov 2026 15:59:39 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: shivamkalra98@zohomail.in, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Weber <weber.aulendorf@gmail.com>,
 Alex Hung <alex.hung@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: use atomic commit for panel power
 savings
Message-ID: <avOFuxeIiMRr2V0p@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261111-abm-sysfs-atomic-v2-1-6dfb19c51ebe@zohomail.in>
 <e925978e-7b1a-4780-9e0c-616b9455058b@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e925978e-7b1a-4780-9e0c-616b9455058b@amd.com>
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

On Tue, Nov 10, 2026 at 02:30:04PM -0600, Mario Limonciello wrote:
> 
> 
> On 11/10/26 13:24, Shivam Kalra via B4 Relay wrote:
> > From: Shivam Kalra <shivamkalra98@zohomail.in>
> > 
> > panel_power_savings_store() mutates connector->state directly and sends a
> > hotplug event. This bypasses atomic commit handling, so the new ABM level
> > is only applied when userspace happens to perform another modeset, and it
> > races with concurrent commits.
> > 
> > Build an atomic state, set the level on the connector state and commit it.
> > If the connector is not attached to a CRTC, keep the level in the current
> > state so the next modeset picks it up, as before.
> > 
> > In amdgpu_dm_atomic_check(), drm_atomic_get_crtc_state() already adds the
> > CRTC to the atomic state so dm_update_crtc_state() can propagate abm_level
> > to the CRTC state. Stop setting new_crtc_state->connectors_changed for ABM
> > changes and keep it only for scaling changes, allowing ABM updates to go
> > through the existing non-modeset stream update path without blanking the
> > panel.
> > 
> > A previous attempt to avoid the modeset by calling into DMUB directly was
> > reverted because it broke the abm_gradual IGT test (8d20a066fa9b,
> > 95aaa207e9ef). This version instead uses the normal atomic stream update
> > path.
> > 
> > Extend the backlight KUnit tests to cover the atomic commit and inactive
> > connector sysfs paths.
> > 
> > Fixes: 63d0b87213a0 ("drm/amd/display: add panel_power_savings sysfs entry to eDP connectors")
> > Signed-off-by: Shivam Kalra <shivamkalra98@zohomail.in>
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Others should comment before merging though too.

I would suggest running this through the weekly promotion before
merging. As I can recall there were a number of edge cases that
prevented this approach in the past (mostly concerning display off and
DC oddities).

> > ---
> > Changes in v2:
> > - Avoid forcing a modeset for ABM-only changes, matching David Weber's
> >    patch [1] (Alex Hung; issue also noted by Sashiko).
> > - Make modeset-lock acquisition interruptible (Alex Hung).
> > - Inline the state update and remove the redundant connector-state
> >    lookup (Alex Hung).
> > - Reuse existing connector-state helpers in KUnit (Sashiko).
> > - Add a KUnit test for the sysfs commit branch with an attached CRTC.
> > - Run the amd_abm IGT suite, including abm_gradual.
> > - Link to v1: https://lore.kernel.org/r/20261031-abm-sysfs-atomic-v1-1-a99068f3b49c@zohomail.in
> > 
> > [1] https://lore.kernel.org/amd-gfx/20260813112634.11455-3-weber.aulendorf@gmail.com/
> > 
> > Testing:
> > - KUnit: amdgpu_dm_backlight, 74/74 tests passed.
> > 
> > - Hardware: v2 backported to 7.1.13-stable-manual on Rembrandt
> >    (DCN 3.1.2, eDP-1). All five amd_abm IGT subtests passed, including
> >    abm_gradual. No HOTPLUG=1 events were captured.
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  3 +-
> >   .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 64 +++++++++++++++---
> >   .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 79 +++++++++++++++++++++-
> >   3 files changed, 132 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index dfbc384fbbdb..256699cdd0b5 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -6304,8 +6304,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
> >   			goto fail;
> >   		}
> > -		if (dm_old_con_state->abm_level != dm_new_con_state->abm_level ||
> > -		    dm_old_con_state->scaling != dm_new_con_state->scaling)
> > +		if (dm_old_con_state->scaling != dm_new_con_state->scaling)
> >   			new_crtc_state->connectors_changed = true;
> >   	}
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> > index 27546febf90d..97684a58cd3d 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> > @@ -719,31 +719,73 @@ ssize_t panel_power_savings_store(struct device *device,
> >   {
> >   	struct drm_connector *connector = dev_get_drvdata(device);
> >   	struct drm_device *dev = connector->dev;
> > +	struct drm_modeset_acquire_ctx ctx;
> > +	struct drm_connector_state *conn_state;
> > +	struct dm_connector_state *dm_conn_state;
> > +	struct drm_atomic_commit *state;
> > +	u8 abm_level;
> >   	long val;
> >   	int ret;
> >   	ret = kstrtol(buf, 0, &val);
> > -
> >   	if (ret)
> >   		return ret;
> >   	if (val < 0 || val > 4)
> >   		return -EINVAL;
> > -	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> > -	if (to_dm_connector_state(connector->state)->abm_sysfs_forbidden)
> > +	abm_level = val ?: ABM_LEVEL_IMMEDIATE_DISABLE;
> > +
> > +	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
> > +	state = drm_atomic_commit_alloc(dev);
> > +	if (!state) {
> > +		ret = -ENOMEM;
> > +		goto out_ctx;
> > +	}
> > +	state->acquire_ctx = &ctx;
> > +
> > +retry:
> > +	conn_state = drm_atomic_get_connector_state(state, connector);
> > +	if (IS_ERR(conn_state)) {
> > +		ret = PTR_ERR(conn_state);
> > +		goto out_backoff;
> > +	}
> > +
> > +	dm_conn_state = to_dm_connector_state(conn_state);
> > +	if (dm_conn_state->abm_sysfs_forbidden) {
> >   		ret = -EBUSY;
> > -	else
> > -		to_dm_connector_state(connector->state)->abm_level = val ?:
> > -			ABM_LEVEL_IMMEDIATE_DISABLE;
> > -	drm_modeset_unlock(&dev->mode_config.connection_mutex);
> > +		goto out_state;
> > +	}
> > -	if (ret)
> > -		return ret;
> > +	dm_conn_state->abm_level = abm_level;
> > +
> > +	/*
> > +	 * Without a CRTC there is no stream to update and nothing to commit.
> > +	 * Keep the level in the current state so the next modeset picks it
> > +	 * up, matching the behavior of the sysfs interface.
> > +	 */
> > +	if (!conn_state->crtc) {
> > +		to_dm_connector_state(connector->state)->abm_level = abm_level;
> > +		goto out_state;
> > +	}
> > +
> > +	ret = drm_atomic_commit(state);
> > +
> > +out_backoff:
> > +	if (ret == -EDEADLK) {
> > +		drm_atomic_commit_clear(state);
> > +		ret = drm_modeset_backoff(&ctx);
> > +		if (!ret)
> > +			goto retry;
> > +	}
> > -	drm_kms_helper_hotplug_event(dev);
> > +out_state:
> > +	drm_atomic_commit_put(state);
> > +out_ctx:
> > +	drm_modeset_drop_locks(&ctx);
> > +	drm_modeset_acquire_fini(&ctx);
> > -	return count;
> > +	return ret ? ret : count;
> >   }
> >   EXPORT_IF_KUNIT(panel_power_savings_store);
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> > index c6d15fb8ad98..586e838a8f63 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> > @@ -20,6 +20,7 @@
> >   #include "amdgpu_mode.h"
> >   #include "amdgpu_dm.h"
> >   #include "amdgpu_dm_backlight.h"
> > +#include "amdgpu_dm_connector.h"
> >   #include "amdgpu_dm_kunit_test_helpers.h"
> >   #include "amd_shared.h"
> >   #include "link_service.h"
> > @@ -514,6 +515,43 @@ static void dm_test_register_backlight_device_success(struct kunit *test)
> >   			adev->dm.backlight_dev[0]), 0);
> >   }
> > +static int
> > +dm_test_panel_power_savings_atomic_commit(struct drm_device *dev,
> > +					  struct drm_atomic_commit *state,
> > +					  bool nonblock)
> > +{
> > +	struct drm_connector_state *new_conn_state;
> > +	struct drm_connector *connector;
> > +	int i;
> > +
> > +	for_each_new_connector_in_state(state, connector, new_conn_state, i)
> > +		to_dm_connector_state(connector->state)->abm_level =
> > +			to_dm_connector_state(new_conn_state)->abm_level;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct drm_connector_funcs dm_test_panel_power_savings_connector_funcs = {
> > +	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
> > +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > +};
> > +
> > +static const struct drm_mode_config_funcs dm_test_panel_power_savings_mode_funcs = {
> > +	.atomic_commit = dm_test_panel_power_savings_atomic_commit,
> > +};
> > +
> > +static void
> > +dm_test_panel_power_savings_crtc_destroy(struct drm_crtc *crtc)
> > +{
> > +	drm_crtc_cleanup(crtc);
> > +}
> > +
> > +static const struct drm_crtc_funcs dm_test_panel_power_savings_crtc_funcs = {
> > +	.destroy = dm_test_panel_power_savings_crtc_destroy,
> > +	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
> > +	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
> > +};
> > +
> >   static struct drm_connector *setup_panel_power_savings_connector(struct kunit *test,
> >   							 struct device **device_out,
> >   							 struct dm_connector_state **state_out)
> > @@ -527,6 +565,7 @@ static struct drm_connector *setup_panel_power_savings_connector(struct kunit *t
> >   	adev = dm_kunit_alloc_adev(test);
> >   	ret = drmm_mode_config_init(&adev->ddev);
> >   	KUNIT_ASSERT_EQ(test, ret, 0);
> > +	adev->ddev.mode_config.funcs = &dm_test_panel_power_savings_mode_funcs;
> >   	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
> >   	device = kunit_kzalloc(test, sizeof(*device), GFP_KERNEL);
> > @@ -536,7 +575,11 @@ static struct drm_connector *setup_panel_power_savings_connector(struct kunit *t
> >   	KUNIT_ASSERT_NOT_NULL(test, state);
> >   	connector->dev = &adev->ddev;
> > +	connector->funcs = &dm_test_panel_power_savings_connector_funcs;
> > +	connector->index = 0;
> > +	kref_init(&connector->base.refcount);
> >   	connector->state = &state->base;
> > +	state->base.connector = connector;
> >   	dev_set_drvdata(device, connector);
> >   	*device_out = device;
> >   	*state_out = state;
> > @@ -614,10 +657,43 @@ static void dm_test_panel_power_savings_store_sets_disable(struct kunit *test)
> >   	setup_panel_power_savings_connector(test, &device, &state);
> >   	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "0", count),
> > -			 (ssize_t)count);
> > +			(ssize_t)count);
> >   	KUNIT_EXPECT_EQ(test, state->abm_level, ABM_LEVEL_IMMEDIATE_DISABLE);
> >   }
> > +/**
> > + * dm_test_panel_power_savings_store_commits_with_crtc - Test store with CRTC
> > + * @test: The KUnit test context
> > + */
> > +static void dm_test_panel_power_savings_store_commits_with_crtc(struct kunit *test)
> > +{
> > +	struct dm_connector_state *state;
> > +	struct drm_connector *connector;
> > +	struct drm_crtc *crtc;
> > +	struct device *device;
> > +	size_t count = strlen("3");
> > +	int ret;
> > +
> > +	connector = setup_panel_power_savings_connector(test, &device, &state);
> > +
> > +	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
> > +	KUNIT_ASSERT_NOT_NULL(test, crtc);
> > +	ret = drm_crtc_init_with_planes(connector->dev, crtc, NULL, NULL,
> > +					&dm_test_panel_power_savings_crtc_funcs,
> > +					NULL);
> > +	KUNIT_ASSERT_EQ(test, ret, 0);
> > +	drm_atomic_helper_crtc_reset(crtc);
> > +	KUNIT_ASSERT_NOT_NULL(test, crtc->state);
> > +	state->base.crtc = crtc;
> > +
> > +	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "3", count),
> > +			(ssize_t)count);
> > +	KUNIT_EXPECT_EQ(test, state->abm_level, 3);
> > +
> > +	state->base.crtc = NULL;
> > +	drm_crtc_cleanup(crtc);
> > +}
> > +
> >   /**
> >    * dm_test_panel_power_savings_store_forbidden - Test forbidden update
> >    * @test: The KUnit test context
> > @@ -1939,6 +2015,7 @@ static struct kunit_case dm_backlight_test_cases[] = {
> >   	KUNIT_CASE(dm_test_panel_power_savings_show_reports_level),
> >   	KUNIT_CASE(dm_test_panel_power_savings_store_sets_disable),
> >   	KUNIT_CASE(dm_test_panel_power_savings_store_forbidden),
> > +	KUNIT_CASE(dm_test_panel_power_savings_store_commits_with_crtc),
> >   	KUNIT_CASE(dm_test_panel_power_savings_store_rejects_invalid_text),
> >   	KUNIT_CASE(dm_test_panel_power_savings_store_rejects_out_of_range),
> >   	/* amdgpu_dm_backlight_get_device_index */
> > 
> > ---
> > base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
> > change-id: 20261031-abm-sysfs-atomic-c79505f63a2e
> > 
> > Best regards,
> > --
> > Shivam Kalra <shivamkalra98@zohomail.in>

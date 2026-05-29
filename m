Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859B3CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 15:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDDCF11213D;
	Fri, 29 May 2026 15:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EkrVL3+S";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF21111213D
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780069243; x=1811605243;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=UY6HwgODe3VUE12l6NyxaTgsONfL+sQ5SNS1y4kkhkk=;
 b=EkrVL3+Sdgq7Jxw2Mk8AZ0NZSOYnPHhnnh14fKAafAutNm28zmJMcEKy
 t0NSNYOeS/xZr2KpC2iohNtdVZEOMLgEz6TSp6n1qOB0dIr/zI5Gck/3d
 bbrTEJBkKB/gXdFHpd04sAWyYCYZqf2C9dqF9iYme3gP8ZhDgogy5zes9
 WnlucDk0Z2EnxuQx7EitHAJ9Eia2Hi4vQ07WCQgM4mSfMN1Cg+8ckESii
 5a7U2wzud7+mdgZyySsPs2AzRzGCYQVhNFGoRC6eP2lkw+Y/YJXCpO0FY
 t8hPF3klfUCp5hIui3+LbHhJcD56R3blIfBo8ZfQpxBGactP+Nh7lgS2P w==;
X-CSE-ConnectionGUID: 47c0LBfIQ/iZs/M1sXI40w==
X-CSE-MsgGUID: g4idromxQqu3xaoJlTc9qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="80650242"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="80650242"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:40:43 -0700
X-CSE-ConnectionGUID: BW5eGX28SgW6QWE6db+06g==
X-CSE-MsgGUID: BMW1JflOTae3/iD1QyNQMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="242984071"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.65])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:40:41 -0700
Message-ID: <a078055731cbd917748ff7a6ae4bc6155c88f5b9.camel@linux.intel.com>
Subject: Re: [PATCH] drm: Set dev->registered back to false in case of
 register failure
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Cc: dri-devel@lists.freedesktop.org, Andi Shyti
 <andi.shyti@linux.intel.com>,  Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Date: Fri, 29 May 2026 17:40:38 +0200
In-Reply-To: <ffhsttic5k5les6get26rzteyg5hknaeydkdzlvfcejdcejz5e@wszixwzpttea>
References: <20260522154037.46892-3-krzysztof.niemiec@intel.com>
 <c55da1fa43e00d755191520e8c03a7659c6e892f.camel@linux.intel.com>
 <ednzkzzbdyabfyvgwkpwqttueqh5taaovhuidfkyc3e2tupnia@7a56amg3bmto>
 <38ac02bee3cc6aff18af80324ae794ab72745724.camel@linux.intel.com>
 <ffhsttic5k5les6get26rzteyg5hknaeydkdzlvfcejdcejz5e@wszixwzpttea>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
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

On Fri, 2026-05-29 at 17:27 +0200, Krzysztof Niemiec wrote:
> On 2026-05-29 at 14:49:29 GMT, Janusz Krzysztofik wrote:
> > On Thu, 2026-05-28 at 17:24 +0200, Krzysztof Niemiec wrote:
> > > On 2026-05-25 at 10:16:32 GMT, Janusz Krzysztofik wrote:
> > > > Hi Krzysztof,
> > > >=20
> > > > On Fri, 2026-05-22 at 17:40 +0200, Krzysztof Niemiec wrote:
> > > > > The dev->registered variable was initially added in such a way th=
at it
> > > > > is only set after all functions that could have failed have been =
called
> > > > > and haven't returned an error. However, since then, the function
> > > > > drm_modeset_register_all() is being checked for its return value,=
 which
> > > > > opens a possibility of failing the register after setting the reg=
istered
> > > > > variable anyway. drm_dev_register() cleans up after itself in cas=
e of
> > > > > failure, mimicking the functions called in drm_dev_unregister(), =
with
> > > > > the exception of drm_client_sysrq_unregister() and
> > > > > drm_panic_unregister() (_register() counterparts of which are not
> > > > > checked for their return values), and the dev->registered flag.
> > > > >=20
> > > > > This creates a situation in which after calling drm_dev_register(=
)
> > > > > nothing is registered (as the function entered an error path and =
cleaned
> > > > > up), but the device is reported as being registered according to =
the
> > > > > dev->registered variable.
> > > > >=20
> > > > > This, for example, confuses the WARN_ON() in drm_mode_object_regi=
ster(), which
> > > > > is raised if a non-dynamic mode object is attempted to be unregis=
tered
> > > > > in between the drm_dev_register() and drm_dev_unregister() calls.=
 If
> > > > > drm_dev_register() fails - meaning the device *isn't* registered =
-
> > > > > currently it still reports dev->registered =3D true, which trigge=
rs the
> > > > > WARN_ON(), even though the usage is correct in that instance.
> > > > >=20
> > > > > Set dev->registered back to false in the error path to prevent th=
is.
> > > >=20
> > > > While you've also submitted a patch ("drm/i915: Remove drm_dev_unre=
gister()
> > > > from the error path during i915_driver_register()") that adjusts i9=
15
> > > > handling of register / unregister steps after this fix, have you ch=
ecked if
> > > > other drivers are prepared for that and won't be affected?
> > >=20
> > > I just did; there'd be a problem if in the error path triggered by
> > > failing drm_dev_register, some driver relies on the dev->registered
> > > variable to be true to do its work.
> >=20
> > OK, maybe my doubts about other drivers were groundless.  The flag is
> > described as DRM internal after all, and cleaning it in the error unwin=
d
> > path seems fully justified.  However, please review your commit
> > description.  Trying to understand why drm_mode_object_register() might
> > call WARN_ON() when dev->registered is true, I found it doesn't, and th=
at's
> > probably its _unregister() counterpart that may do that.  With no stack
> > trace attached, that's confusing for a reviewer.  Such WARN_ON()s may b=
e
> > hit not only due to inconsistencies internal to DRM, but also as a resu=
lt
> > of drivers incorrectly / unexpectedly calling some DRM functions.
>=20
> Yes, I've made a mistake in the commit log, I meant _unregister() - see
> [1]. Do you think going through how i915, specifically, hits this
> WARN_ON() would be a sufficient example?

Yes, especially if you are confident that's not i915 fault and you can tell
when and how i915 may legitimately trigger that path and why it may expect=
=C2=A0
dev->registered not set by then.  I think that would evidently help to
convince reviewers that the change is really needed.

Thanks,
Janusz


>=20
> Thanks,
> Krzysztof
>=20
> [1] https://elixir.bootlin.com/linux/v7.0.10/source/drivers/gpu/drm/drm_m=
ode_object.c#L106-L117
>=20
> >=20
> > Thanks,
> > Janusz
> >=20
> >=20
> > >=20
> > > There are two main patterns of doing the error path in the DRM driver=
s
> > > I've seen - one is just directly returning from the overarching funct=
ion
> > > with drm_dev_register()'s error return value. The other is invoking t=
he
> > > .unbind handler of the driver via component_unbind_all(), and most of
> > > the time those call drm_dev_unregister() right away, which sets the
> > > dev->registered value to false anyway. In these two cases (if
> > > drm_dev_unregister() is called in the second one), the problem doesn'=
t
> > > affect the driver at all.
> > >=20
> > > In the case of i915 not setting the variable to false on failure
> > > triggered a WARN_ON() in drm_mode_object_unregister() because that is
> > > invoked indirectly in the error path due to the complexity of our
> > > init code (even xe just returns directly instead). If another driver
> > > calls that function in its error path, it will just silence (correctl=
y)
> > > the WARN_ONs there.
> > >=20
> > > The only driver that explicitly checks for dev->registerd in its erro=
r
> > > path is msm, which does that to see if it needs to invoke
> > > drm_dev_unregister() during unload. This patch actually fixes a bug t=
here
> > > because otherwise _unregister() would be called even if _register() f=
ails,
> > > which is not correct.
> > >=20
> > > All other uses of the variable are outside the error path of their
> > > respective drivers, so they should function as intended even after th=
e
> > > change.
> > >=20
> > > Thanks
> > > Krzysztof
> > >=20
> > > >=20
> > > > Thanks,
> > > > Janusz
> > > >=20
> > > >=20
> > > > >=20
> > > > > Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_drv.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.=
c
> > > > > index 985c283cf59f..92403d79bb64 100644
> > > > > --- a/drivers/gpu/drm/drm_drv.c
> > > > > +++ b/drivers/gpu/drm/drm_drv.c
> > > > > @@ -1116,6 +1116,7 @@ int drm_dev_register(struct drm_device *dev=
, unsigned long flags)
> > > > >  	if (dev->driver->unload)
> > > > >  		dev->driver->unload(dev);
> > > > >  err_minors:
> > > > > +	dev->registered =3D false;
> > > > >  	remove_compat_control_link(dev);
> > > > >  	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
> > > > >  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);

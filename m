Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215BAC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7298410F071;
	Thu, 20 Aug 2026 14:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="EIRMG86I";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F90410F071
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787237115; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UiRyjSrp8ZVdJwCrPSLx8EfZ6Ht58qyKoWmb2hMv6+t9DO2i8Xzlg1I6KC5c9dTprLAsFamr1w6K8Sdca6a55VOqR6tlghslULaeemTaB/KK2AxKymesh+ze2EZTvZAi3F9lE2der9HFGa69zbCWiaDMA5A6c+b0PatXSY/0NRY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787237115;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yPfE/sHUiu2o6V0dJ0UBJAphD1W/z5Eu+CoSCFRLdRA=; 
 b=R+DuOvDii37wM/+ldOeleFwLijbFDb9RO2EoEoBybu505ef3lNdlVGv7/b3ay9ueA9bB2zk03hTSsWk0Y770OMph/wrsx4vz5j05RWohm7sEb6HQ13x3ODdJoXzp9SC26qT6FdFN0W073qdZZsFoz9aljNaP4EPO3U8tKnUa24k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787237115; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=yPfE/sHUiu2o6V0dJ0UBJAphD1W/z5Eu+CoSCFRLdRA=;
 b=EIRMG86IcaSmpPzhjoFaGNTPdAIBbcud+Cx4bpRqlPedm2xs5AZ543fCsH7F9rHq
 XQW5lm/JRv/Dz2pzdykL0pC31EDJOP+VlonkHxc4MIcr8wzVkSZQj1IWaFiCC7fonsw
 UoClxGKxzkO6VKDGImUazn/SJhkSl3/oHF7RNIA0=
Received: by mx.zohomail.com with SMTPS id 1787237112729448.9155883822127;
 Thu, 20 Aug 2026 07:45:12 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 5D56918082F; Thu, 20 Aug 2026 16:45:09 +0200 (CEST)
Date: Thu, 20 Aug 2026 16:45:09 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Damon Ding <damon.ding@rock-chips.com>, 
 sashiko-reviews@lists.linux.dev, conor+dt@kernel.org,
 devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, robh@kernel.org
Subject: Re: [PATCH v6 3/5] drm/bridge: analogix_dp: Restore mandatory
 samsung DP DT properties
Message-ID: <aocKgCU2hw1jJsKl@venus>
References: <20260707040613.1992841-1-damon.ding@rock-chips.com>
 <20260707040613.1992841-4-damon.ding@rock-chips.com>
 <20260707041711.4F7351F000E9@smtp.kernel.org>
 <00d3f58e-73bb-41da-a2df-dfeeca644b6f@rock-chips.com>
 <DKSQUNWA86GP.9NHE4ADGYLQH@bootlin.com>
 <ba494eae-c17f-4a15-8276-fd5dfb372337@rock-chips.com>
 <DKSXCKHFS3T7.2UK43K8F0TUGZ@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tqb3otqvwl2eytwz"
Content-Disposition: inline
In-Reply-To: <DKSXCKHFS3T7.2UK43K8F0TUGZ@bootlin.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/287.221.66
X-ZohoMailClient: External
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


--tqb3otqvwl2eytwz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 3/5] drm/bridge: analogix_dp: Restore mandatory
 samsung DP DT properties
MIME-Version: 1.0

Hi,

On Wed, Aug 19, 2026 at 02:37:59PM +0200, Luca Ceresoli wrote:
> Hello,
>=20
> On Wed Aug 19, 2026 at 10:19 AM CEST, Damon Ding wrote:
> > Hi Luca,
> >
> > On 8/19/2026 3:32 PM, Luca Ceresoli wrote:
> >> Hello Damon,
> >>
> >> On Wed Jul 15, 2026 at 10:32 AM CEST, Damon Ding wrote:
> >>> On 7/7/2026 12:17 PM, sashiko-bot@kernel.org wrote:
> >>>> Thank you for your contribution! Sashiko AI review found 1 potential=
 issue(s) to consider:
> >>>> - [Critical] Failing probe when deprecated DT properties are missing=
 breaks DT ABI and prevents their deprecation.
> >>>> --
> >>>>
> >>>> --- Patch [3]: [PATCH v6 3/5] drm/bridge: analogix_dp: Restore manda=
tory samsung DP DT properties ---
> >>>> commit b573dba50acc6087122ffa4a65680322f4d004f8
> >>>> Author: Damon Ding <damon.ding@rock-chips.com>
> >>>>
> >>>> drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties
> >>>>
> >>>> This commit reverts a change that made the samsung,link-rate and
> >>>> samsung,lane-count properties optional for Exynos DP. It adds error =
checking
> >>>> to fail the probe early if these properties are missing, aiming to p=
revent
> >>>> link training failures caused by zero values.
> >>>>
> >>>>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/d=
rivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> >>>>> index 8cf6b73bceac0..293d8adfe9856 100644
> >>>>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> >>>>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> >>>> [ ... ]
> >>>>> @@ -1258,10 +1259,14 @@ static int analogix_dp_dt_parse_pdata(struc=
t analogix_dp_device *dp)
> >>>>>    		 * NOTE: those property parseing code is used for
> >>>>>    		 * providing backward compatibility for samsung platform.
> >>>>>    		 */
> >>>>> -		of_property_read_u32(dp_node, "samsung,link-rate",
> >>>>> -				     &video_info->max_link_rate);
> >>>>> -		of_property_read_u32(dp_node, "samsung,lane-count",
> >>>>> -				     &video_info->max_lane_count);
> >>>>> +		if (of_property_read_u32(dp_node, "samsung,link-rate", &val))
> >>>>> +			return dev_err_probe(dp->dev, -EINVAL,
> >>>>> +					     "Failed to get samsung,link-rate\n");
> >>>>
> >>>> [Severity: Critical]
> >>>> Does failing the probe when this property is missing break the DT AB=
I?
> >>>>
> >>>> Since samsung,link-rate is a deprecated property, a modern schema-co=
mpliant
> >>>> Device Tree might intentionally omit it. If a system boots with such=
 a DT,
> >>>> this check will fail the probe with -EINVAL and disable the display.
> >>>>
> >>>> Could the driver instead fall back to hardware maximums or sensible =
defaults
> >>>> when the deprecated property is absent, rather than returning an err=
or?
> >>>>
> >>>
> >>> I'm afraid it's difficult to provide a universal sensible default val=
ue
> >>> here.
> >>>
> >>> The samsung,lane-count and samsung,link-rate values vary significantly
> >>> across Exynos DP device trees, so a generic fallback to hardware
> >>> maximums cannot guarantee stable link training.
> >>>
> >>> Even though these two properties are marked deprecated, all existing =
DTS
> >>> files in our projects have already populated them completely. Moreove=
r,
> >>> the current link training logic relies on these two parameters; omitt=
ing
> >>> either will directly cause link training failures at runtime.
> >>>
> >>> Therefore, retaining the mandatory property check in probe is a
> >>> reasonable approach for now.
> >>
> >> I'm still not convinced we should turn an optional property into manda=
tory,
> >> after having been optional since 2016 (based on the commit in the Fixe=
s:
> >> tag).
> >>
> >> The sure thing is we cannot break existing devices which upgrade to a =
new
> >> kernel.
> >>
> >> Se the question is: if a device is missing one of these properties, or
> >> both, what happens? The video_info->max_link_rate and/or
> >> video_info->max_lane_count will be zero, correct? And if they are zero=
, is
> >> there even a remote possibility that the device will work somehow, may=
be
> >> only with some rare low resolution or whatever?
> >>
> >> If the answer is "yes, there is a remote possibility that one sich dev=
ice,
> >> with some maybe rare configuration, will work", then no, we cannot make
> >> this property mandatory now. There can be devices out there working wi=
thout
> >> these proberties, and they would be broken.
> >>
> >> If the answer is "there is no way at all a device can work without one=
 or
> >> both properties", with a good explanation based on the code flow and
> >> hardware docs, then we can consider this change.
> >>
> >
> > Sorry for the confusion, I just submitted the v7 series which crossed
> > with your reply.
> >
> > To answer your question: there is no way at all a device can work
> > without these properties. Here is the code flow when either
> > max_link_rate or max_lane_count is 0 (helped by AI):
> >
> >    analogix_dp_commit()
> >      -> analogix_dp_full_link_train(dp, max_lanes =3D 0, max_rate =3D 0)
> >
> >    analogix_dp_full_link_train(max_lanes, max_rate):
> >        // Read sink capabilities via DPCD and sanitize them
> >        link_rate   =3D read_dpcd(DP_MAX_LINK_RATE); // >=3D 0x06 after =
fixup
> >        lane_count  =3D read_dpcd(DP_MAX_LANE_COUNT);// >=3D 1 after fix=
up
> >
> >        // Clamp by the limits from DT
> >        if (link_rate > max_rate)                // 0x06 > 0, always true
> >            link_rate =3D max_rate;                // link_rate =3D 0
> >        if (lane_count > max_lanes)              // 1 > 0, always true
> >            lane_count =3D max_lanes;              // lane_count =3D 0
> >
> >        // Configure TX with the zeroed values
> >        set_link_bandwidth(link_rate =3D 0)
> >            // writel() is only executed for bwtype =3D=3D 0x06/0x0a,
> >            // so LINK_BW_SET is never written and stays at reset value;
> >            // phy_configure() is called with link_rate =3D 0.
> >
> >        set_lane_count(lane_count =3D 0)
> >            // writel(0, ANALOGIX_DP_LANE_COUNT_SET) enables 0 lanes;
> >            // phy_configure() is called with lanes =3D 0.
> >
> >        // Program sink for link training
> >        drm_dp_dpcd_write(DP_LINK_BW_SET, {link_rate =3D 0, lane_count =
=3D 0})
> >            // DP spec requires link rate in {0x06, 0x0a, 0x14} and
> >            // lane count in {1, 2, 4}. Writing zeros is illegal, so the
> >            // sink cannot enter the training state.
> >
> >        // Training loop
> >        for (lane =3D 0; lane < lane_count /* 0 */; lane++)
> >            // loop body never executes; training_lane[] stays
> >            // uninitialized and no training register is ever programmed
> >
> > Since the sanitized sink values are always non-zero (link_rate >=3D 0x0=
6,
> > lane_count >=3D 1), the clamping with a zero maximum unconditionally
> > forces the training parameters to zero. Clock recovery can never be
> > achieved, so link training fails deterministically.
>=20
> Thank you very much for the detailed analysis! To it is enough to
> proceed. I'll review your v7.

Can't the default for missing properties just be changed to 4 lanes
and 0x14 rate and the DP link training would automatically train to
less lanes / rates based on hardware capabilities (which would
render the properties basically useless except for a small speedup
during link training)?

Greetings,

-- Sebastian

--tqb3otqvwl2eytwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqHEuoACgkQ2O7X88g7
+ppo7xAAoAFq+SlYLTwYJFRpvU7ZU/TcvGu3G8vMyVjzCBk5AsjgJ/o5MkoN5yLT
vkgGjfeC0UMup7x9jUZsX2zNHVrVDjvkWEOgXmNwDHGYrQm0/hHwwtpf+oCSOkKp
wfJDq8lxl8goiTGaT9dTb9W5zh++1I96SRqIRhi97jWgKQVbdkCpPFgi0J2RLpP8
DC/FbESwtEqOwGDthzhMaJfl2J4EoV3G4UZXRyXi0FsPLEm06jLasWZbasG3SBFq
eXGEV3vDVoVmKAuEC62f/E+NTp+gpDAyoKuThrSfWZfJcse6MDPte/tLCArchN7Q
16mqk1N9IFwkQ19IZ9Y42dy0SgO1nMeXBjuyeX9lbIBRy+iUp8dQvcpOI21Ituue
enGdBKGHjeAyGSTsBTCNhVZljLqseHc6wwEb2scambpWSFTNK5h/6HWKZEymrAnR
4oV3tBkNR04CSq2vsc8YkcUiXZKoGosfJNg24/MkoBhqrODMUsTYVhuh+9ic/gKy
UIgzMiVCPUwu+UPXPHjk1TLw+lmnvvhSHASOdi4zf9lTVjWQFj6GjI0Zj232vOIu
UBBoqV6eLxqn3HWsxb52/1G9PjghxZQ/rG06+kVZaZpDsqISnnYwmZ3X5joxsj+E
JUTHdRiF5GZYZfnEKkqatiaRv+/BEAXyZKGyZSl6mIoi2BQGXlk=
=hxts
-----END PGP SIGNATURE-----

--tqb3otqvwl2eytwz--

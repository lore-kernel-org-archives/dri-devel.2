Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316BA606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=feQKeC63
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8555010E3EA;
	Thu, 12 Nov 2026 05:25:09 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2547210E3EA;
 Thu, 12 Nov 2026 05:25:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9V9CVMV+ISjPbX1KCyd8/tlpgP/NGMYS9ZhqZZOF8MPlrueUd9bNR0XqNDzhzGbVolVmPHYam0AO4wqCjyJGEVQd/SsKZCppzBbrfOL+WdDNq8Fx07+hmmHb4rvf4ur/K1hOnqpQSyu8X4ls5Msqd3/3/0AjN+IUvaVHBaIq07oGrfSoehIAzVfUg7TNtIrYce9RuKgkvFOEg3Vk0ZLCEUrx1oGO+SOpVoM0r0/kpOHaTFkNR1Qy0CcCo9NI3Ny3Y0UlsyYnPfLvKh0dUbI3JBzjsWYO6JiFRYrDRR8NKMrDHngA0oDLUh9kvLYydoyCUbYkbxYChBTqsbIT9D5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yb8GpO99s+D1WayFIp3MI/disiTUxVREDVxGDmp4JNM=;
 b=fp6XCgmsUwzHevVntxUMdDJDJn/p67wtMPg51D5RfmHcDkB5raUSLdjcabr1fnvP3plzgQ91eDQ1vd97sxFmexFQnWzUaC8xnElN+5pcUKx862LXSQtoCefF39yxEbSBfPdP46kJXHNenMpxbzWV9VOH3kUb7bbnfoTWxQcyXhuZoMkLewb5xYsfcv3wJyU47jL6r99vkN0/Du5/rUt9xC6EcEW6F2ISVc3bNWmg90KDw5+DjykoMrE+1ScyhZRCOHZCuYPRYPoVU49tEDPSShlgz3TNNdBXWG5wG7dSvoDBPs4bFZufufpgGzspsK1J6l7uZ2185sbNizmujntFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb8GpO99s+D1WayFIp3MI/disiTUxVREDVxGDmp4JNM=;
 b=feQKeC63fI0L6B7Xc5NF7ukm/kgEcqodMODNlIRqojTrbt0RmMCY8KhFms+rVVXgF9cpYsoFp0rviO2ZgcWproNejFkqw3XGCqetZxCkf+CpiXM2AmxyavioERQ5yTrfBooH9qR7IoN7uMBomQCdv+VcjDz4Gi2KMsQfhO8zZOdwzCWmnXp3bPzXf5U4pbvFPpFW5oL37Lky5DzvsrPMBBEpRzB7l4O5OHHzXhnj8c/janLs5VjdAD8xivstGHot7ktJSOq4qjSESwS6n+yoohK3VOxMY4U07/KTrmDw2itTYtgrWm8kU7PIphfRgZzup/UxVarM8mwo2Tw0A3zfnw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16)
 by DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 05:24:56 +0000
Received: from BL0PR12MB4914.namprd12.prod.outlook.com
 ([fe80::4921:cbe6:78cd:b445]) by BL0PR12MB4914.namprd12.prod.outlook.com
 ([fe80::4921:cbe6:78cd:b445%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 05:24:56 +0000
Date: Wed, 11 Nov 2026 23:24:50 -0600 (CST)
From: Vidith Madhu <vmadhu@nvidia.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
cc: Xaver Hugl <xaver.hugl@gmail.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 =?ISO-8859-15?Q?Michel_D=E4nzer?= <michel.daenzer@mailbox.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 09/27] drm: Add VRR target frame rate properties
In-Reply-To: <20261105-vrr-limiter-uapi-v2-9-55f4215be2c2@collabora.com>
Message-ID: <812a813c-05cf-190d-6006-b8f63764beb7@nvidia.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-9-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: SJ0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::30) To BL0PR12MB4914.namprd12.prod.outlook.com
 (2603:10b6:208:1c4::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB4914:EE_|DS2PR12MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: 51807aff-63b0-415d-4b20-08df407d49dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|18002099003|22082099003|3023799007|6133799003|4143699003|11063799006|261022113327099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|56012099006|261021121427099003|261021135927099003|261102130727099003|261009223327099003|261009220027099003|261102123227099003|261009221727099003|261009221227099003|10067099003;
X-Microsoft-Antispam-Message-Info: 8PEXXlE9mz60VJp8LtJ43T7uAfoFyLPiBpk2pUu8yCab6SoHoE7JcCkm5j3lu05rIEjEAsFaHWC/uHcWt1dyfmnfnkCElKAL7lCG9Yu8f5+17xyiyf5T8LZwTB3207QNQTBnJL2qPLT7kttqU24OVObR0Iswc9N1EN1xVLHTLkxhFYVfsuYBlJNiYI+F36dECuEKfkRVfiXoHRNw7eUwnSmRLS9L1Ur6uS1FQuDVKBplevft8Qb0JPsGsA7CnsOMA9vW4KRj37+BYf0MDsRpMEPC+gg56KLr/eKFc6+B97qkveQwK8sYUGVPdlr93tTOy5Hw/UbcORueMvP7GPlFJST2VehSxxhjfJEubVWc8aku+qBTil+2vKjdmMCZyghnex8kfpLOp1DK8cLl0LHJmp+Rh7cypl+oPVDLb9o8dbbWz/e+Zs8MYbuCqRTbn8NciZJxMExjOPAa2YOgtKq8z0tIHwDyAq/oBcSd25tneB1V698PSyAFunriRXaO0dVYHtbna/zJ06Cv1wecozZ71bXKCCEtGwH3iJUboqUG5XGCEU1JvQNsC8SJxA5mKKvnNpho2makG7cJxLM3oUoamrpZhMNpSrDnkxqWMZahGGCpIW/lIon7CGKid0AFrkxakFXTasYgba3/4sRdnurUe2QZ5oPMuM8GIyJ5mF6A0l4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(6133799003)(4143699003)(11063799006)(261022113327099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(56012099006)(261021121427099003)(261021135927099003)(261102130727099003)(261009223327099003)(261009220027099003)(261102123227099003)(261009221727099003)(261009221227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zD4ovX0Bz8+MaWehoq1tLOMbuNOyvGet7/ouLpxshXLs1JaG2Zv1/XYjKrsj?=
 =?us-ascii?Q?054TdSe+1OUzpoq6Bkz2q5YnIUys0SlV2c97bQn27y3/+pBfQNnpruxQicnr?=
 =?us-ascii?Q?zOusvS9H4A56ywfpQaJcppEdyNK1K1H2vriD6x488fUeKAvpUrcnh+4ym301?=
 =?us-ascii?Q?kQb4ah81EnQ+22ZVoKWtosyM11WGxpcadJU9TUENvs8mkIcjG+n2bJ1SoBuk?=
 =?us-ascii?Q?AlsWauN9v6JUqfhpLZzWGmbKPJ6Rw/nmwJhk277lKil65Byp8TfR+kJn9RfS?=
 =?us-ascii?Q?ao+znjIXzN2LOj8VwTKKrOnFAziqbUxt2CCKjmDmOWn1NUbOHf4E977gpHLo?=
 =?us-ascii?Q?IsivHQi/lYsYzjGnhhy4xjIAufNXqBbLDInH92eucK0iX89/oQ1qKFxk02Jy?=
 =?us-ascii?Q?N9DEElsneyeGM+0DAwYIqtjVohIcH8GkErz8xhSArDWUWU2H8W+vbRwxQqTe?=
 =?us-ascii?Q?vZfjQr0Ynjy8Ior8D40wBCFskEVIraHhNUJ63VmXbasdWgesFlJWzUZ0eDsT?=
 =?us-ascii?Q?urZ/FkV/xdaDaK72De4N6aFNSdnC3ySeUzbEtloC0DlI7rXjC7yCQIjC64RO?=
 =?us-ascii?Q?hWkZWF/YvJhAa4//kxJwZAhOmxayCvhRWocNoQ0dqKkWKpkXJVatHwA1f+Yh?=
 =?us-ascii?Q?olA/25sly9e6554kbcDN4x5KhqS418fQzE1z3fhIFswLAy9YRY/RK/L8rHf3?=
 =?us-ascii?Q?DnAUoapW8EhvDuCJgnZ1GD9fVAgz81aNM+LoU0FIUWorxQOvLuqtYfM+m0W7?=
 =?us-ascii?Q?W5IkroHjR/QVBCAbusq5a3q1tsmydEDcgKOz7ldZ5bNMzh6eg52MyH/QA5Ju?=
 =?us-ascii?Q?JuSJJLrFHSe3Y0XoXqCzjA56rbk18PMGrqglXFlb3Akxxo3zQoxs7w8r9/KG?=
 =?us-ascii?Q?PA5qnktkp7ebmsEJd/jGkDQ7sFwR0T4p8WpsxjAyLrZhpx7uyKSfafedCYUQ?=
 =?us-ascii?Q?Dm2aXcXobsPEZhroV0hZmSN8MhdBxQj+EWfDzXG80Q5usxKIemN4gyQgAHmx?=
 =?us-ascii?Q?d8X61FOxoN6xo1UiqDXt2paeqn5RMpt04rkpGUOMPF/baSAlAdpTRmWEuPKD?=
 =?us-ascii?Q?FHtcR+V9tb7MtYQyYQzZvSGEpGVgjmHjctwVo21KM3NhxNX0XQOPuA9QIbM6?=
 =?us-ascii?Q?QwrgzELgf/OvZuDQ7HkXFxXZhAD65sRi2DW4f9Nw7pDS4OFNM8E+nHdTLeVb?=
 =?us-ascii?Q?/aL6zhV+fz/0/tWoYtNazE+4RVesK9DvRbUzOKu+XhCp0LBLgeedHrx6nZ2r?=
 =?us-ascii?Q?4oPe/QKKM9x4WTMhO+sYhpWKqRtRvJrPdeoJQUKdAdj9YDQ+kKrbUyerpMTY?=
 =?us-ascii?Q?Uk/VENurGTF36QN5LieImKfNX27F8am1cSG3jnHdhWsg3xIGydA3GRRImE7G?=
 =?us-ascii?Q?qsrYEe1yIgZ1hOsJGvtsyAWMmt2955n6srvJAQ/kkpS1ik+B/QJfXB+t/XMt?=
 =?us-ascii?Q?Lym9VTUEpdHNGq15NocRcS19oXNqpRFg0cF3UEIzSC9vPrLLvoj7RuHjP7yg?=
 =?us-ascii?Q?0LjfKKyWS/iy0pfPzhYMHNEh4A6auT2WBR69b6fWfQm/C6NFBQQvpMXiZWSP?=
 =?us-ascii?Q?q/IK4TN+fpv1Xrf48/qEQkOg6IbgQWlSO/DY3zpCpRB704EtdfU56+FMZOkc?=
 =?us-ascii?Q?AVvMID1W7IdTMRt6U+YGYsN41lboVfpn9AFE+v6j+aGidUKNxIJ221Cfn5dl?=
 =?us-ascii?Q?D9g4VBEQzcyiNqmD8ace0EmSMRc9f3lNdM8Vkr8rTCeIOH2N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51807aff-63b0-415d-4b20-08df407d49dc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 05:24:56.6738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53OzprR4q+m77IbiDOyTj5w52ke0LVnMI2g8ZRF9XkgWBbLNruqjxPvlTbuWZSA0PIix0QQ3lY6ggWD02x3MvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9750
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



On Thu, 5 Nov 2026, Nicolas Frattaroli wrote:

> Userspace may wish to set a target frame rate for the Variable Refresh
> Rate mechanism. There are multiple possible ways such a target could be
> communicated.
> 
> It's desirable for userspace to not only set a fixed target, but a
> target range within which VRR may operate. This is because even if a
> sink advertises a certain range as supported, said range may not be the
> ideal range to use, as numbers on the extreme end of the range may
> induce flickering or other glitches.
> 
> There's four choices to how one bracketing value for the target range
> could be communicated:
> 1. Target frame rate in something like millihertz
> 2. Target frame period in something like usecs
> 3. Target vtotal value
> 4. Target frame rate as a fraction expressed by two integers
> 
> Choice 1 is unpleasant as it would introduce some amount of rounding to
> common broadcast framerates like 24/1.001, which seems minor except that
> exact matches to standard framerates would rely on making all userspace
> and kernel agree on a specific method of rounding. This is sure to go
> wrong, so is disqualified.
> 
> Choice 2 has the same problem as 1, with the added complication that
> the EDID's VRR range is expressed in frames per second, and other HDMI
> features express things in frames per second as well, which would
> require possibly imprecise computations.
> 
> Choice 3 is disqualified as mechanisms other than VRR, such as FVA, may
> also modify the vtotal value. Additionally, it has the same drawbacks of
> choice 2 and 1.
> 
> Choice 4 is therefore what's implemented. The frame rate 24/1.001Hz, for
> example, is expressed as nominator=24000 and denominator=1001. As there
> is both a minimum and a maximum, there are 4 properties in total: two
> numerators, and two denominators. A fixed rate with no variability is
> expressed by setting the minimum fractional and the maximum fractional
> properties to the same value.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_atomic.c      | 14 ++++++++++++
>  drivers/gpu/drm/drm_atomic_uapi.c | 24 ++++++++++++++++++++
>  drivers/gpu/drm/drm_connector.c   | 48 +++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_crtc.c        | 34 +++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_mode_config.c | 20 ++++++++++++++++
>  include/drm/drm_crtc.h            |  6 +++++
>  include/drm/drm_mode_config.h     | 45 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 191 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 9bb761eda59f..da5c6925c349 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -489,6 +489,7 @@ EXPORT_SYMBOL(drm_atomic_get_crtc_state);
>  static int drm_atomic_crtc_check(const struct drm_crtc_state *old_crtc_state,
>  				 const struct drm_crtc_state *new_crtc_state)
>  {
> +	const struct drm_crtc_vrr_state *vrr = &new_crtc_state->vrr_state;
>  	struct drm_crtc *crtc = new_crtc_state->crtc;
>  
>  	/* NOTE: we explicitly don't enforce constraints such as primary
> @@ -544,6 +545,19 @@ static int drm_atomic_crtc_check(const struct drm_crtc_state *old_crtc_state,
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * Reject VRR limiter ranges that only specify one end of the limit, or
I think specifying just one end of the limit should still be a valid case, 
the client may want to use the default bound on one side implied by the 
base timings/min. refresh rate and constrain the other.

> +	 * specify a numerator > 0 with a denominator that is 0.
> +	 */
> +	if ((!vrr->vrr_min_n || !vrr->vrr_min_d ||
> +	     !vrr->vrr_max_n || !vrr->vrr_max_d) &&
> +	    (vrr->vrr_min_n > 0 || vrr->vrr_max_n > 0)) {
> +		drm_dbg_atomic(crtc->dev,
> +			       "[CRTC:%d:%s] incomplete VRR limiter range\n",
> +			       crtc->base.id, crtc->name);
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 127bdd77802b..c95eaa9697c4 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -420,6 +420,22 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
>  		return ret;
>  	} else if (property == config->prop_vrr_enabled) {
>  		state->vrr_enabled = val;
> +	} else if (property == config->prop_vrr_min_numerator) {
> +		if (val > U32_MAX)
> +			return -EINVAL;
> +		state->vrr_state.vrr_min_n = val;
> +	} else if (property == config->prop_vrr_min_denominator) {
> +		if (val > U32_MAX)
> +			return -EINVAL;
> +		state->vrr_state.vrr_min_d = val;
> +	} else if (property == config->prop_vrr_max_numerator) {
> +		if (val > U32_MAX)
> +			return -EINVAL;
> +		state->vrr_state.vrr_max_n = val;
> +	} else if (property == config->prop_vrr_max_denominator) {
> +		if (val > U32_MAX)
> +			return -EINVAL;
> +		state->vrr_state.vrr_max_d = val;
>  	} else if (property == config->degamma_lut_property) {
>  		const size_t elem_size = sizeof(struct drm_color_lut);
>  		u64 lut_size;
> @@ -505,6 +521,14 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
>  		*val = (state->mode_blob) ? state->mode_blob->base.id : 0;
>  	else if (property == config->prop_vrr_enabled)
>  		*val = state->vrr_enabled;
> +	else if (property == config->prop_vrr_min_numerator)
> +		*val = state->vrr_state.vrr_min_n;
> +	else if (property == config->prop_vrr_min_denominator)
> +		*val = state->vrr_state.vrr_min_d;
> +	else if (property == config->prop_vrr_max_numerator)
> +		*val = state->vrr_state.vrr_max_n;
> +	else if (property == config->prop_vrr_max_denominator)
> +		*val = state->vrr_state.vrr_max_d;
>  	else if (property == config->degamma_lut_property)
>  		*val = (state->degamma_lut) ? state->degamma_lut->base.id : 0;
>  	else if (property == config->ctm_property)
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index a44afba8c5ff..33c4195db58b 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2593,6 +2593,54 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
>   *	    - Game - set display to game mode if display supports it,
>   *	      regardless of CRTC state
>   *	    - Off - set display to VRR disabled mode, regardless of CRTC state
> + *
> + * VRR Limiter/Target Properties
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + * The ``VRR_{MIN,MAX}_{NUMERATOR,DENOMINATOR}`` properties expose a mechanism
> + * through which userspace can control the desired range of refresh rates in
> + * which VRR is allowed to operate. Each rate is expressed as a
> + * numerator/denominator fraction of refresh rates in Hz, allowing for rational
> + * target rates like 24/1.001 Hz with no loss of precision or ambiguity.
> + *
> + * If the minimum and maximum rate are set to the same value (and not 0), they
> + * are understood as a fixed target rate. This is especially useful for media
> + * playback, where the content's frame rate is both constant and known in
> + * advance. In such cases, a refresh rate that is not an integer multiple of the
> + * content's frame rate will introduce judder, since not every frame is
> + * displayed for the same amount of time. A modeset of the display with a
> + * compatible rate may in those cases be either undesirable or impossible, but
> + * the rate can still effectively be reached through VRR.
> + *
> + * If one end of the limit is set (e.g. minimum), the other end (e.g. maximum)
> + * must also be set. Any rational with a numerator of 0 is treated as 0/0
> + * regardless of denominator.
> + *
> + * .. _VRR-MIN-NUMERATOR:
> + *
> + * "VRR_MIN_NUMERATOR":
> + *	Default &drm_crtc integer property forming the numerator of a
> + *	numerator/denominator pair of a frame rate to set as the minimum VRR
> + *	target rate. Set to 0 to disable.
> + *
> + * "VRR_MIN_DENOMINATOR":
> + *	Default &drm_crtc integer property forming the denominator of a
> + *	numerator/denominator pair of a frame rate to set as the minimum VRR
> + *	target rate. If :ref:`VRR_MIN_NUMERATOR <VRR-MIN-NUMERATOR>` is not
> + *	zero, it must be non-zero.
> + *
> + * .. _VRR-MAX-NUMERATOR:
> + *
> + * "VRR_MAX_NUMERATOR":
> + *	Default &drm_crtc integer property forming the numerator of a
> + *	numerator/denominator pair of a frame rate to set as the maximum VRR
> + *	target rate. Set to 0 to disable.
> + *
> + * "VRR_MAX_DENOMINATOR":
> + *	Default &drm_crtc integer property forming the denominator of a
> + *	numerator/denominator pair of a frame rate to set as the maximum VRR
> + *	target rate. If :ref:`VRR_MAX_NUMERATOR <VRR-MAX-NUMERATOR>` is not
> + *	zero, it must be non-zero.
>   */
>  
>  /**
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 5295ec122e0d..4c29c6e15df9 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -324,6 +324,40 @@ static int __drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *
>  	return 0;
>  }
>  
> +/**
> + * drm_crtc_attach_vrr_limiter_properties - Attach VRR limiter props to CRTC
> + * @crtc: The CRTC to attach the properties to
> + *
> + * Attach the VRR limiter target minimum and maximum frame rate properties to
> + * @crtc. The driver implementing @crtc must use atomic mode setting.
> + *
> + * This convenience function is to be used by drivers which implement all the
> + * logic required for the VRR limiter uAPI to function.
> + *
> + * Returns:
> + * Zero on success, negative error on failure.
> + */
> +int drm_crtc_attach_vrr_limiter_properties(struct drm_crtc *crtc)
> +{
> +	struct drm_mode_config *config = &crtc->dev->mode_config;
> +
> +	if (!drm_drv_uses_atomic_modeset(crtc->dev))
> +		return -EINVAL;
> +
> +	drm_object_attach_property(&crtc->base,
> +				   config->prop_vrr_min_numerator, 0);
> +	drm_object_attach_property(&crtc->base,
> +				   config->prop_vrr_min_denominator, 0);
> +	drm_object_attach_property(&crtc->base,
> +				   config->prop_vrr_max_numerator, 0);
> +	drm_object_attach_property(&crtc->base,
> +				   config->prop_vrr_max_denominator, 0);
> +
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_crtc_attach_vrr_limiter_properties);
> +
>  /**
>   * drm_crtc_init_with_planes - Initialise a new CRTC object with
>   *    specified primary and cursor planes.
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index 48a56f23dadb..da967d60f832 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -535,6 +535,26 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
>  		return -ENOMEM;
>  	dev->mode_config.prop_vrr_enabled = prop;
>  
> +	prop = drm_property_create_range(dev, 0, "VRR_MIN_NUMERATOR", 0, U32_MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_vrr_min_numerator = prop;
> +
> +	prop = drm_property_create_range(dev, 0, "VRR_MIN_DENOMINATOR", 0, U32_MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_vrr_min_denominator = prop;
> +
> +	prop = drm_property_create_range(dev, 0, "VRR_MAX_NUMERATOR", 0, U32_MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_vrr_max_numerator = prop;
> +
> +	prop = drm_property_create_range(dev, 0, "VRR_MAX_DENOMINATOR", 0, U32_MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_vrr_max_denominator = prop;
> +
>  	prop = drm_property_create(dev,
>  			DRM_MODE_PROP_BLOB,
>  			"DEGAMMA_LUT", 0);
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index bfb2b0741625..9004f7c2f21e 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -66,6 +66,10 @@ struct drm_plane_helper_funcs;
>  struct drm_crtc_vrr_state {
>  	u16 cur_vtotal;
>  	u16 max_vtotal;
> +	u32 vrr_min_n;
> +	u32 vrr_min_d;
> +	u32 vrr_max_n;
> +	u32 vrr_max_d;
>  	u16 base_vtotal;
>  	bool dynamic;
>  };
> @@ -1247,6 +1251,8 @@ struct drm_mode_set {
>  
>  #define obj_to_crtc(x) container_of(x, struct drm_crtc, base)
>  
> +int drm_crtc_attach_vrr_limiter_properties(struct drm_crtc *crtc);
> +
>  __printf(6, 7)
>  int drm_crtc_init_with_planes(struct drm_device *dev,
>  			      struct drm_crtc *crtc,
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 084517beb924..c8d5286f9267 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -702,6 +702,51 @@ struct drm_mode_config {
>  	 */
>  	struct drm_property *prop_vrr_enabled;
>  
> +	/**
> +	 * @prop_vrr_min_numerator: Default atomic CRTC property to indicate the
> +	 * numerator of a numerator/denominator variable refresh rate minimum
> +	 * target frame rate.
> +	 *
> +	 * If not zero, @prop_vrr_min_numerator divided by
> +	 * @prop_vrr_min_denominator must result in a frame rate above the
> +	 * sink's minimum VRR rate.
> +	 */
> +	struct drm_property *prop_vrr_min_numerator;
> +
> +	/**
> +	 * @prop_vrr_min_denominator: Default atomic CRTC property to indicate
> +	 * the denominator of a numerator/denominator variable refresh rate
> +	 * minimum target frame rate.
> +	 *
> +	 * If @prop_vrr_min_numerator is set, @prop_vrr_min_denominator must not
> +	 * be 0, and @prop_vrr_min_numerator divided by @prop_vrr_min_denominator
> +	 * must result in a frame rate above the minimum VRR rate.
> +	 */
> +	struct drm_property *prop_vrr_min_denominator;
> +
> +	/**
> +	 * @prop_vrr_max_numerator: Default atomic CRTC property to indicate the
> +	 * numerator of a numerator/denominator variable refresh rate maximum
> +	 * target frame rate range.
> +	 *
> +	 * The fraction expressed by this property divided by its corresponding
> +	 * denominator must be equal to or greater than the value of
> +	 * @prop_vrr_min_numerator.
> +	 */
> +	struct drm_property *prop_vrr_max_numerator;
> +
> +	/**
> +	 * @prop_vrr_max_denominator: Default atomic CRTC property to indicate
> +	 * the denominator of a numerator/denominator variable refresh rate
> +	 * maximum target frame rate range.
> +	 *
> +	 * If @prop_vrr_max_numerator is set, @prop_vrr_max_denominator must not
> +	 * be 0, and @prop_vrr_max_numerator divided by @prop_vrr_max_denominator
> +	 * must result in a frame rate equal to or above @prop_vrr_min_numerator
> +	 * divided by @prop_vrr_min_denominator.
> +	 */
> +	struct drm_property *prop_vrr_max_denominator;
> +
>  	/**
>  	 * @dvi_i_subconnector_property: Optional DVI-I property to
>  	 * differentiate between analog or digital mode.
> 
> -- 
> 2.56.0
> 
> 

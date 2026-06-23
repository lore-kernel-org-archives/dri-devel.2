Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3BDCDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D04EF89EB1;
	Tue, 23 Jun 2026 13:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SsQG83SX";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013042.outbound.protection.outlook.com
 [40.93.196.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6593410EB6D
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFUYjJRjP7mPdZeClbxR16jD7Dw6Caz6A94uBHOneUKzq/TdUNCPPhgpO8GxFwwhl+19oK5TmeoAkGMSroazbxACez8nB7Jsn73SK3b1JqLeyLKxmLnP0+k3fYJ60QHSwPJfVLg4Qb6NzYBYBT4g40iPB4MdQ7VnEEGBeuoCPTwIuwd2d/G0obTxn8OitZ4L78s+faZ7b0XBV3xHsldMPghb3ZZm6h14VH9lxOfam0IIXRFsBWXcsTVkG+Plghvnr4VFECnhHF9QhwGeDBG7diVnPI01c+ROvRw4jVOuaVuQ4rkbNzHwzrmCpw1vsYxYEHJwK0n0YMD0PTHNmtKNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RThWJ1psdYonXsgCEtW1ZGQkYFh+TFtkVw+WME2R7s=;
 b=BkpKOgFoyhlIPrvlF19249MTqN8SG3G8mSVWLygxmEiFE0BdxdSv6E58ydBfg+ZECbqnMtiUYQBG5L/x6P7P+Qub/GvPTVG9fncNiag0KRacIT1ngQ1jhvMMm68Q0SFHeRCS+8+FpARZuvM72shIOJOs4PB9z4ScjJS59N5IWcIUcrYgXBjuYACq1hYxgOieJHyczj55l0w3/N5zWUvwbsH5n8XZK0mapkpqvYj6NJYjCliQEPwZQO08D2RMUbQ2+LVj5WGo2FlFt2ZMHdBd4ulMN8xulB5lopxF1M+q41DV/kXNT9AaGIeEBwKV9Xc8d7e/ypK0LrfYwZmCyoj37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RThWJ1psdYonXsgCEtW1ZGQkYFh+TFtkVw+WME2R7s=;
 b=SsQG83SXKkDoIdrp444tcNzJ17x1WF5SWUYeK/COGq2HJfuKuyB9OdgeAKLj3i2SgsTbE0OC/Ly40lSgjkbrm5NFEeelpeP4aFFYddWAzh8ubRqsUp40mytVozF3tCZgw2Q5QLsIUCj2ZU9AnDTGeZsR30JJTLPatzX1ikx6KwKrFgtSIt20lscNjAhlrzRziieG3TKiCGSKHQ0DFkIjA7vO0ZgObjArVg0zmwJ5SThcCx24FUn7aJpsOptZdwE7pLUZFT4MCAGGyfT3C9H/gSdqtE+6dZfjoykb8XTWiAPSLIfk3EgVlAsLfw5ajm3LNrEqfwyZpHcTo1PGhrGCOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 13:43:51 +0000
Received: from CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315]) by CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315%5]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 13:43:51 +0000
Date: Tue, 23 Jun 2026 15:43:45 +0200
From: Thierry Reding <treding@nvidia.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh, 
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 6/6] drm/sysfb: simpledrm: Read panel orientation from
 DT node
Message-ID: <ajqNeuYBiSAHHLZn@orome>
X-NVConfidentiality: public
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-7-tzimmermann@suse.de>
 <ajlfgXEO4NR-TZ4s@orome>
 <808d917d-28c4-4a84-a647-d5dc9123bd32@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q2syeh6gxmhpr7jo"
Content-Disposition: inline
In-Reply-To: <808d917d-28c4-4a84-a647-d5dc9123bd32@suse.de>
X-ClientProxiedBy: BE1P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::10) To CH0PR12MB8488.namprd12.prod.outlook.com
 (2603:10b6:610:18d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8488:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 5472f72c-a441-4c07-3b03-08ded12d75b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|366016|376014|22082099003|18002099003|11063799006|5023799004|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: CDUa2FCbTd16PPdU8DGkB6c9IeeN1CFR54aBFzNufQ/p9PkkK1Z5HfybOfrFq/zqC26xnv92zUo6f98rqdHLEEAIM8zlq8tQjrpVL4Vz+NN2ueez/5Bo9js9JDG1tNPalVCc6WjNFi69KeOKgKQ7d71eCrYDh6d/Np0dWuLKk/0x4MaVvh4wTpdh86dK/atQUnA5bu/A7t5jsYjoyO213+w7TDwYSPcMhCEYdXbNuYkc6txJhSAhsXgif3aoPnVIGlJe/ruXA+pNtR2zN0vq50vf5C344ry/l9ohfC9x8zcrA1QTsqcLszAVutqLkfopOgvJAtldPvRef/xfohGOgrkMujoI49NmSMsCeZxuVuYyeospEaHRMF66Df0KcoZISTnLYUHLxuj4EUQB+Yvz0NhuDDmBpD3Uf6rF4sC/xZaqdcDFMTXro6rThB7OC3jNhVW4ojiaoQlYtRnGkMLJjU2cfbiVD9GpjopNDnlPqpm58QecXMQgbFKzFmRkO7KqUhhSpNdAc7YWOTtMc5IrbWEEamIN6aHIgz3DDQjsqFO4nql8yPleqCNUAzOEZyIuI7ol5tgXXVxzj0McLL47FiWY9/1zLDrqMVZM8Em6Zgs921nvJMLhKumHiy6IYwK5gqEyFTbDvNYXuyqE0sYALUIIGlRFePjVzWcbt+IWgdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(376014)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3lRHt0H5Z3fL3FSSDaX1nPeozl7hG2i6kv8TjLFEhejf8pj0Jq86wHzwKSJ?=
 =?us-ascii?Q?jwrG6qsuE7kJF2+TZ4J6rDLd3I223Jww4UVqOvl+WOrAXqGOvj6QD/trZCob?=
 =?us-ascii?Q?li4HxWqEimEW9trtAWZ1pjpbIKDfvEo8ef3xGoUSaIZ1zVjU1HhCYukM8rZ0?=
 =?us-ascii?Q?UZabn/lZz0pTvvsa4Htay4trQPF+C4seU6UhJ+prgLT0D/WycQgJKLcjtmLB?=
 =?us-ascii?Q?5SwruR521dngbWJEYBeW6hwYRyngTBkJwIXWJLIRvYwwwsmQD7hBKSXBIcKP?=
 =?us-ascii?Q?ALLtIqDiuyk9P9dxyw+HImOm0Kecu0VMaIPgIqrW8iD6q1iqSxaZz2ALsqbG?=
 =?us-ascii?Q?cgvQsz9GsD2SSu44NlFWxUJLY6H2JNf/vh4cZBh7N8NTBGPjZwDYfoK7zYQC?=
 =?us-ascii?Q?s2a9YW9wIiFiMKbUW5VfcWikvYPlGE87/nXDnUw0pNfKUKZ6v0oeVMKa85CB?=
 =?us-ascii?Q?1rBZzlCCN/jjFlyd+j6uoyzjHoa49PxqWTzeQcrKOEPZnDwlEIZhXgRR7Pmp?=
 =?us-ascii?Q?FoaNtHiXCJko2YlLVE9hy+D12Q+ooZGj6ZdTDZ4jnuQKd6ATrHi/zt5z6b3x?=
 =?us-ascii?Q?M3QZ7wFzyDrybSbX90e8AmRYvtMThtlp8D8U1eM1ydZVkX3LhDkzelLumV/r?=
 =?us-ascii?Q?RimENaz+6gVWi7xPlcXZJ+v06TCqjzW5MV5p2cDUU6/SAVaGDeAKtZUGeCfx?=
 =?us-ascii?Q?7W4BBIhmjgDwjGtmy3bQBanOVF1YHqfJE45ovemfLPkjV6Zc8wHSUapZl/vC?=
 =?us-ascii?Q?sKoY71MAvD7Iikm9OEM//TUIQOkW8PpQZ6w9uchGA0R48EFVR9XbNhCthgvh?=
 =?us-ascii?Q?u1IvyoHu52cfygLHcoR4sEUoJYub6foEOfjTQrQ9Q2BkEzhuew6HD1keAKS8?=
 =?us-ascii?Q?hU3w+yx5owRB73vwCqQYfTp9bK3H6sCP7hrgMkJXr2icqBT9xV6EOBV17N8p?=
 =?us-ascii?Q?WQCJ76Dw+jBwDtee1enJL05tnl6tDam43UcjkmujBdtaQbDAE7NvusO7rEcm?=
 =?us-ascii?Q?1nIurvB0Gmch6kNUllNB4JKJMH64u/k1Ulz1c/gyzo/q1gQdAhYlBxjzeL/V?=
 =?us-ascii?Q?62IEwoLzymrAOhUPSltV7X3G2I2g4U+3XPsb/XOVmZ8hVk0+FPDvUzV+B09N?=
 =?us-ascii?Q?Z3Vn7ehTnuVXhVZNhe9bd7Fiu7Ues+crHAfmLcej6URFnVqinzMPEGEQwmo5?=
 =?us-ascii?Q?llJhmu8LxdLZhsKyIUz97DYQkToG7noRfNqa1qrwql6pvOKhd2X8UTPDyZjE?=
 =?us-ascii?Q?wOHfFXB09cEEX2UdtdovDKANTcp/dgliSTf9b5BVxssstVB7XqqW/fR8W9V+?=
 =?us-ascii?Q?yOgnXPl11GMRFjnIg1vlYFdjcYRu/DfSDOenL8GEyLYvAzFZMQRZDu3bnRra?=
 =?us-ascii?Q?DU/y/nVQSM3kNb0RaSVbJo2HTKM9BI32pUG09b6elM7R0/P3X0atWsPbCxdl?=
 =?us-ascii?Q?0QjPaKnSbUkQBOJMDPBnwQeGOyh5ZhPJaLUV0e/kkTXNmAVg8xgEIU/fttTa?=
 =?us-ascii?Q?7BS7BYhtfeq+dIu/ec8oQIWh+jrvpiK8Ud2TxhbRIMf000DPI46JJuGjpH24?=
 =?us-ascii?Q?KvBsQ7xLSqLky1WQwdrY1E19SPvqZMsmCoyHS/kdwwMRJ0LD4RoyfNdBXYr/?=
 =?us-ascii?Q?Ikzfe3Ljc649J3QfqthTsgKpLXah4sGpOyfo0/qxSuzpTkeW8xEfrrsqUWLt?=
 =?us-ascii?Q?fBz5u41wXnln8j79hSQq0tw+I/4KVRHsgIXybvD1mMz4UTSc3QakzI1jAAHS?=
 =?us-ascii?Q?vvj42ADOq3fQh21h9Uyv1APHb2+uYvvySnyNXI1EJnyrQ8SOD1Mra38KLrG/?=
X-MS-Exchange-AntiSpam-MessageData-1: fuAloIVuWfCbHA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5472f72c-a441-4c07-3b03-08ded12d75b1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:43:51.3105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AD/3kqLJNk0z9abm4hQSyz9AKtTEu3liaBmW9sqebR/nOsq4gojudy8YKtDamYtRIQNT7Zthx0e7VtN5IWOBlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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

--q2syeh6gxmhpr7jo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 6/6] drm/sysfb: simpledrm: Read panel orientation from
 DT node
MIME-Version: 1.0

On Tue, Jun 23, 2026 at 11:04:22AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 22.06.26 um 18:17 schrieb Thierry Reding:
> > On Mon, Jun 22, 2026 at 03:19:40PM +0200, Thomas Zimmermann wrote:
> > > A DeviceTree panel node can specify the panel's rotation in steps
> > > of 90 degrees. Set the DRM connector orientation from the field.
> > > Do nothing if the field is missing or invalid.
> > >=20
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > ---
> > >   drivers/gpu/drm/sysfb/simpledrm.c | 32 ++++++++++++++++++++++++++++=
+--
> > >   1 file changed, 30 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysf=
b/simpledrm.c
> > > index a04f0c852ea4..b585d17ca817 100644
> > > --- a/drivers/gpu/drm/sysfb/simpledrm.c
> > > +++ b/drivers/gpu/drm/sysfb/simpledrm.c
> > > @@ -221,6 +221,33 @@ simplefb_get_panel_height_mm_of(struct drm_devic=
e *dev, struct device_node *of_p
> > >   	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "height=
-mm");
> > >   }
> > > +static enum drm_panel_orientation
> > > +simplefb_get_panel_orientation_of(struct drm_device *dev, struct dev=
ice_node *of_panel_node)
> > > +{
> > > +	int ret;
> > > +	u32 rotation;
> > > +
> > > +	ret =3D of_property_read_u32(of_panel_node, "rotation", &rotation);
> > > +	if (ret) {
> > > +		drm_dbg(dev, "simplefb: cannot parse panel rotation: error %d\n", =
ret);
> > Why is this debug level? Maybe we don't want an error if the property is
> > absent, but if it really can't be parsed, why not print out a proper
> > error?
> >=20
> > > +		return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> > > +	}
> > > +
> > > +	switch (rotation) {
> > > +	case 0:
> > > +		return DRM_MODE_PANEL_ORIENTATION_NORMAL;
> > > +	case 90:
> > > +		return DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
> > > +	case 180:
> > > +		return DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
> > > +	case 270:
> > > +		return DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
> > > +	default:
> > > +		drm_dbg(dev, "simplefb: cannot parse panel rotation: value %u\n", =
rotation);
> > Same here. Seems like we should be verbose when this contains an invalid
> > value. DT checkers should catch these already, so if the invalid value
> > makes it here, maybe we should sound the alarm.
>=20
> Ok. The review bot told me about of_drm_get_panel_orientation(). I intent=
 to
> reimplement this patch on top of that helper.

Makes sense, yeah.

Thierry

--q2syeh6gxmhpr7jo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmo6jZEACgkQ3SOs138+
s6F3WhAAhVbfQ0HZuJLF5oaD89yT6G1VgePpOYJaTGC9RF4DTAiLUnnt+dJHygP7
udeoGfyJIvcYnPEdVghJIavZOGhqe0RtlonzbANDb3CHgw0BitXWmxXetyZL4O0T
wrv1mRv49sQRhu3bcTN7e9g2tLisiKj84tlppiRPXddM/jLDl1WD3QadNv7To7x7
Z+/gQ8krul534+cUsduc81kQ2pY1SIR3ay+T6ycBQBM7zZqFLHBAKKt76beqYQgf
HP+RNtUfTNl0M0eqx2buOr1jsfkbsLjLQ+WoHqXytF6HJG186vuqWqTQkWT7P7aI
N4cpgwZq9WnmKc5R4bpNkuXST07ZXYa8mTAkQImzjqvp4E7lYJHvLs5Im+z7E8eP
Q+AfjWso8iqh6eZ47qghAUxmz5fN1Xm4Mjcq5LF5XmRZrT62NTppmZjXKKl35rGH
pRVWP9sQVINsVqQGicPkhj9GfmijOAD0d0u8uDP0psrZCzl+pnL2InXKiAa9zdG4
ALAGNb/MTVD+KF8h+QWsspNuZAr2wPSMBFCDpUQgZRcZ01Uj6D84l9g0lN7VJXVh
Ou5C5s/HEKjU8qthDlecb8VmDCIy+yolNfOKJ/1epEPbqebRDcIvqU8Diucg9YXH
zOMDqeA+YsiR43OGJEaXboika+KwifQwxRQXstn29X56tRuvAp4=
=/IIC
-----END PGP SIGNATURE-----

--q2syeh6gxmhpr7jo--

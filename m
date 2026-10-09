Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05BFCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C644810E9EA;
	Fri,  9 Oct 2026 09:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="r8/LA4r+";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A5C10E9EA
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 09:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRPPP4qIEb5kTbUB0tA7RYZar2ekQYu1sWn1S9Nzz4pG3M0/2ndXhaaTdaVVrJtPHgrUbQbFRetlnc6a1LLw2xSZcCHx3XEYULaIOYOp8OdO5dmIeHnQcJ+BFJA29cK4f+Din7GfXcjKPM5becbLv+VsjLlgn95EowOSoBxZN5bZD5FFqnwxWXaBbvMF2Znr541NSHwyNE7XtDBTMoyN8bq7fBEkq7G8Qe0zs6woAkpekFwhHHDTwMHh2FPj34OyMYDtaoPJqyaQenhm+dZpRvsAFWizv1nxIeUDQtL0sUhm6CF9J9cXRA7LhSs9lbtWtkQQ0fKJpi9hyLpYAlU1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Rb00XrAHRRNxrFsrMkUz3a075Gz04hTRQeE5CPpZIw=;
 b=hNATMAryeoQAu8bgL004LuFxIrsxI4+j5d+pRvVg22mHCG/qt+1B2rjiYEY1t+jcYU26Iw+MTee1CvIKleJMVftUcJhJHff71a/93cKPK1B4MwygzV8//qOk6Ut168kXR3KpENOzpb2WQV7oLtyK1pG0ewfLA/TBgShkjX5drai3LNabgPuZYonDxISME5rxxYcWOZvxEsKubwSbh/xsY+FHVXoTdetT5aV65M4cqcO4tdJy80EwbuXvx6+/gdSGAUcdVzjkuivyJKGeyVTb3mI4OF5nG/uTmlF6kwPc5BTHiciJvb1dcuUjclIZageNO6/KCWSwtO2IARlVmOvm8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Rb00XrAHRRNxrFsrMkUz3a075Gz04hTRQeE5CPpZIw=;
 b=r8/LA4r+2fcOOkN2qz/a4X1K5ptE9PHJ0IhSIuPrdcOwRvWbf/qssMNgHhf8hSFcIQja5GBUsB+lNiPBGFueF1xYS7ocj2lSE28X3BKQqXsCG2/dqYHPyNCeNnGkM6enpaQ9ZVSGTJoIa/tpwQ2O+eF3f4eUHX/lIK1H7xhApRajqFFqnJRltloXHz7By8S5IKSPcaaWt7QNW8Se4JlOgzTNvrsw3vTx8YzniK/sE+rVEfBe8a6gKqIk6SPv9X1o1gvGlKoIhmbOCBLtA2sGn5qyyfFiqkqdzIY7VN4lCkgvweOQb2nDT1qJqTUmeSSdSr03vaTQEq4mbQIAnGuftw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 09:03:49 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 09:03:48 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, webgeek1234@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
Subject: Re: [PATCH 1/2] drm/tegra: Support swapping chroma planes
Date: Fri, 09 Oct 2026 18:03:45 +0900
Message-ID: <xM99yOJgSRK7DZVKa4Skcw@nvidia.com>
In-Reply-To: <qEporZZOT_abKwO4JObFpQ@nvidia.com>
References: <20261008-tegra-drm-yvu420-v1-0-dc1c443c00f3@gmail.com>
 <20261008-tegra-drm-yvu420-v1-1-dc1c443c00f3@gmail.com>
 <qEporZZOT_abKwO4JObFpQ@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4PR01CA0123.jpnprd01.prod.outlook.com
 (2603:1096:405:379::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d85d5a-ba20-46b2-0e86-08df25e43b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|366016|1800799024|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Lq+2r8Q+PFA3MkNbKE8skOT5szag5cV3dwIguEOIm59ivL0qPsvvbiC+xwUM9gL3K3hyhZ+iq+FMFqAFFxmCCfUOOLX1gBUpIMYjTSqIMntXKsIVR+isAFHhD5ymuZ41AuEYP9LcyA+UzgGdS93wPTvte5gIb65AgDq2aC3HgWBNZkO9qE3raMdon4nV2wSabG7vetOW2XkYo1vZNRmH2c6NxZjGDdqCwFRgHm/niNgR7VF05qpGxrj/ChEuSUq2EINZUHLtbrXUl4XVJffYjNGHcCuk6Am8QXnJRz7Ir5qIIy56CrfJPh4J7UJTH+U1r/u/fgEOjpo8+Uiq61CvUkHqFyh21d5BohrYEtekgWZ+g7CODt8Cu7O/E8sWPg6JSUBnSKYz4oiBQGbmC52fUdoWK2pdDSUdOTgmZr+nsSFW6q1/IRUrOeVOy6G82xWxGbIvcw3zrWOc8CZagQM5Bht8c7oF4+uy9FubvcnWHp6FXNBLA1BQPPgYc4YOZLydSbL7aNRB80zbjjl6CHLvx5v6vDW2Fs/lc86oTVYmySBvP2/SVAPwSV4i0l1MIYCVZCa28qfKPJt4Q3516+E+lOg3KWEykemFXmE5dlI3seA5T1D4DWvaMjVO13L/cbPVHVnx7Y7iV0mhj3pFaQm07r0+PPL2W21TGcIONfbZ7tU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk1tMFI1REVuWENMZk1mVDhZOWlvaW5udzBoTUZsT0hJSDE3TitnUTAyOWk3?=
 =?utf-8?B?V1hxbFcwUEpkUVlQUndFVmNTaDFGaEZYQ0IxZVFRdk9hQ3ZucSs1Yy9rRFpO?=
 =?utf-8?B?V2dWSjUwYitndHA3M0E0aW93aEZJQXgzUkk2dU1Ca2E5NDhJc1kzdytSaG5G?=
 =?utf-8?B?SVhURDRkcEFMWStldG4vaDBUSU1FVG00b05wSEVJY0JSb1l1cDVaSldQSFZ2?=
 =?utf-8?B?dDE4VnY1c1AveGFDdEFPMTFyOFBDaTNSVzJmV29yc1BHc1UyNUZaVjNoRU1p?=
 =?utf-8?B?T1BTbVhNV1pqUzBRaDdKRzREUU1qMWE2U0M0NFpwaXd2bzl5VnhVU2pxL01J?=
 =?utf-8?B?YXpXZkZjSVEza2RsbGZ3MVorSjJPbWRsbjU1NTcrS0xOY1dDdWJaYkthM3VR?=
 =?utf-8?B?dmlwRFppdkZvWER0WWhIdTFvR1l1WHZKczRkSDJ6MXBoN1JJT08rVmQ1TnhP?=
 =?utf-8?B?b0o5TVFQTjA5ZHZJZGtpSk1pNmUvQ0pHbzMyM0h4RGlPV3ZlSk9ZM1FsbmFy?=
 =?utf-8?B?N3B2c1hIZFlvYm9ia09XaFZnMzhyZC9xYWdZWndidWE2K2ZOYUI1WFgweGRw?=
 =?utf-8?B?WExBRVFOb1VIOGM4TXBlU2xJY1ExdVVIMHpGQkpiVUFjdFZWaC9SeFpnSk9Z?=
 =?utf-8?B?Z1IvMlU5ejVmZTVoOS9ROVhlb29vVEJheG15QktWV0tOL2xIVFJpZXJjWGRm?=
 =?utf-8?B?R2lZa2V4TFRyUzRkUDVzd2lod1NqVFBxMWtOanNDYXZuZWFpMVE1SzFQMlR6?=
 =?utf-8?B?Rk5GVTI0TGhLWHBONys0V1E0NDVKeHdTQmNmTHYwRk1NYXdKRlZmWWhWbzBZ?=
 =?utf-8?B?YlJIRVlkZ2VrUTdjTmVpVndiZHI3d3p0cTJ4c3JXditUdWU5c0hhYncrZVlt?=
 =?utf-8?B?eVI0TlRacnhJR3NBQkZDZjMvaTNVM1lCK0hTTk5aQ1VPWWwrcTlYSDFUdmVX?=
 =?utf-8?B?T1RYeGtZelhBdEhWN0lkZDg4WVNoWCtldjZ2ZHdLeElEUEJQMkwzQXV2RmlL?=
 =?utf-8?B?YlQ1di9NOW5lRFpXS1RSOExWQUlNRmV5OEtvMUNZRFJXMW1hdGZnWUtVVHFZ?=
 =?utf-8?B?WnRJZVhZeTVpTmY1YUpUcXFwYjNqMzhnQ3R1QWF2ZllBV3d3amIrdTdpeUl0?=
 =?utf-8?B?YjYwOThvV0F6QnBvS21UZHhuTkxGaFhoOVYzRGI3R2ZCNk1zZXJrOER4ZHBn?=
 =?utf-8?B?ZkM5cHdLZFBYYUMzNElTaW1kL3lDZStzdmtuMjNMbS83ZUlrUzdjQmszRmdK?=
 =?utf-8?B?UlFUd2E1Y1RxL3l4SUlpOHYyM3VLdzBFVHBnbnIrRVJ2Z0toRS9hamFLYUEx?=
 =?utf-8?B?bVdUM1BPbEJncmtUU1MwNFNQS09OVk91czdxbElkeDBOeklaZGhNU2NBNklu?=
 =?utf-8?B?cFVicFR4NTRob01PaUliQWZrdWRYTXFzcUp4Q3FCN2JMbndJbDlyQ2NsZHFE?=
 =?utf-8?B?NUswUy9RNm5kdDh2YXJ3WTlORzBiWFl6WGdNQUhnZ3NJc3FOZnFBNEFlek54?=
 =?utf-8?B?TjhVenJPTFNKbVBLK0FobXFxN1pwWHhZSHc2ZmQ4cXV6WEE3SzFqUDVUcmoy?=
 =?utf-8?B?djJUWjN3RnJZWlp3Y2N1c3gwa05CTWFxOG5zUnczS1hHZi9FUXdyRFI5dWRT?=
 =?utf-8?B?L0tHZVdjVVI5TE90b20zTUUrdHhFaUNEK25aUHc0NmFPaFRuL1hhdFBpS0Ez?=
 =?utf-8?B?QU9HT1k5R2IyM2ZvUkNheHhRZW1yUzhIU09DRzlNOG1HanFjdjJ4NFJaT3Ex?=
 =?utf-8?B?UVJ1NVVKWmU4UEZnNkk1clhkendEbCtPL3UyME8vNVFOUk9tUW0xdmhBc2dy?=
 =?utf-8?B?YzlSY3o3NWVuKzhXSFZqRzhhNFo5OHJqSG12S0RNVG50djMxOW1VWWZZb0ty?=
 =?utf-8?B?UkY1TEdlMnpnbG0xUnRVNmNLQmhrbDJlTkxFL2o4bTE2MFoyTjhaY0UwMW9D?=
 =?utf-8?B?SHdkbmV5Y1hCblVkWS9ZZnNsZDJvVDBaYUlaV1RWeXhabDlQNzQ2bk12VmJ5?=
 =?utf-8?B?QUxIQTlCRlptQzlvODZkOFN0U1JjdWhmcEJJWjg5Sm9TWHhOdllHTEVGWWt1?=
 =?utf-8?B?QnJZbnBTSGRIWHdya0FzRVBhYWZGWkE5Y3RWaGlENUJvLy8vRk1WOTdOSDdW?=
 =?utf-8?B?aTlNNWNNa0JSem9hTTBxMVoyazlWQzllK2dTU1lOZXRKYmh1RnN0T2RFcXIx?=
 =?utf-8?B?enk2QVpSNDQrcHVQY2RiSHlvUUNYaUFMYUsxakMzVXNlcWsyTWcwaEgvYWdS?=
 =?utf-8?B?WHBUeXl6K0diZmdWY0NxR3pzNVF0c05PMEZIa09zYlE0OUFYUXVmZVZLSThM?=
 =?utf-8?B?N0ZYUjJJRzM0WGJURTRaOHZJd3c4eUtiakY0aDFobXo4THRlNURFRkNBNVBv?=
 =?utf-8?Q?jz6l157bpDWiA/LuQd1/Nm3bFwCR9jKGTiwGY8kDvvzZR?=
X-MS-Exchange-AntiSpam-MessageData-1: oAmJX2/DqiVnlw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d85d5a-ba20-46b2-0e86-08df25e43b47
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:03:48.9156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jh/6LuJZVNxoM1jAKd1t1Dnzksa433lNHlG78w5AZSYQbkNIbIy9m3KorMHdeZthn0juBj353NNExZP3NhbW1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
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

On Friday, October 9, 2026 5:59=E2=80=AFPM Mikko Perttunen wrote:
> On Friday, October 9, 2026 5:57=E2=80=AFAM Aaron Kling via B4 Relay wrote=
:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >=20
> > The Tegra display controller supports some yuv types, but not their
> > chroma swapped variants. For example, yuv420 is supported but yvu420 is
> > not. This can be efficiently worked around by just passing the hardware
> > said chroma planes backwards. Add a flag to the plane state struct and
> > handling to both tegradc and nvdisplay paths.
> >=20
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/dc.c    | 17 ++++++++++++-----
> >  drivers/gpu/drm/tegra/hub.c   | 14 +++++++++-----
> >  drivers/gpu/drm/tegra/plane.c |  4 +++-
> >  drivers/gpu/drm/tegra/plane.h |  3 ++-
> >  4 files changed, 26 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> > index b0bfa946e6979..76d3841a17b8b 100644
> > --- a/drivers/gpu/drm/tegra/dc.c
> > +++ b/drivers/gpu/drm/tegra/dc.c
> > @@ -444,7 +444,8 @@ tegra_plane_use_vertical_filtering(struct tegra_pla=
ne *plane,
> >  }
> > =20
> >  static void tegra_dc_setup_window(struct tegra_plane *plane,
> > -				  const struct tegra_dc_window *window)
> > +				  const struct tegra_dc_window *window,
> > +				  struct tegra_plane_state *tegra_plane_state)
> >  {
> >  	unsigned h_offset, v_offset, h_size, v_size, h_dda, v_dda, bpp;
> >  	struct tegra_dc *dc =3D plane->dc;
> > @@ -510,10 +511,13 @@ static void tegra_dc_setup_window(struct tegra_pl=
ane *plane,
> >  	tegra_plane_writel(plane, window->base[0], DC_WINBUF_START_ADDR);
> > =20
> >  	if (yuv && planes > 1) {
> > -		tegra_plane_writel(plane, window->base[1], DC_WINBUF_START_ADDR_U);
> > +		uint8_t u =3D tegra_plane_state->swap_uv ? 2 : 1;
> > +		uint8_t v =3D tegra_plane_state->swap_uv ? 1 : 2;
> > +
> > +		tegra_plane_writel(plane, window->base[u], DC_WINBUF_START_ADDR_U);
> > =20
> >  		if (planes > 2)
> > -			tegra_plane_writel(plane, window->base[2], DC_WINBUF_START_ADDR_V);
> > +			tegra_plane_writel(plane, window->base[v], DC_WINBUF_START_ADDR_V);
> > =20
> >  		value =3D window->stride[1] << 16 | window->stride[0];
> >  		tegra_plane_writel(plane, value, DC_WIN_LINE_STRIDE);
> > @@ -740,7 +744,8 @@ static int tegra_plane_atomic_check(struct drm_plan=
e *plane,
> > =20
> >  	err =3D tegra_plane_format(new_plane_state->fb->format->format,
> >  				 &plane_state->format,
> > -				 &plane_state->swap);
> > +				 &plane_state->swap,
> > +				 &plane_state->swap_uv);
> >  	if (err < 0)
> >  		return err;
> > =20
> > @@ -871,8 +876,10 @@ static void tegra_plane_atomic_update(struct drm_p=
lane *plane,
> >  		if (i < 2)
> >  			window.stride[i] =3D fb->pitches[i];
> >  	}
> > +	if (tegra_plane_state->swap_uv)
> > +		window.stride[1] =3D fb->pitches[2];
>=20
> Based on the comment above, U and V have the same stride, so this
> isn't required.
>=20
> > =20
> > -	tegra_dc_setup_window(p, &window);
> > +	tegra_dc_setup_window(p, &window, tegra_plane_state);
>=20
> Instead of passing the plane state, I'd just add a
>=20
>   swap(window.base[1], window.base[2]);
>=20
> here.
>=20
> Otherwise looks good to me! I also tested on AGX Xavier.
>=20
> Mikko

(Well, sashiko has some findings, please check them as well)

>=20
> >  }
> > =20
> >  static const struct drm_plane_helper_funcs tegra_plane_helper_funcs =
=3D {
> > diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
> > index 448f49f3a7d7e..6427155ac4fdf 100644
> > --- a/drivers/gpu/drm/tegra/hub.c
> > +++ b/drivers/gpu/drm/tegra/hub.c
> > @@ -440,7 +440,8 @@ static int tegra_shared_plane_atomic_check(struct d=
rm_plane *plane,
> > =20
> >  	err =3D tegra_plane_format(new_plane_state->fb->format->format,
> >  				 &plane_state->format,
> > -				 &plane_state->swap);
> > +				 &plane_state->swap,
> > +				 &plane_state->swap_uv);
> >  	if (err < 0)
> >  		return err;
> > =20
> > @@ -664,24 +665,27 @@ static void tegra_shared_plane_atomic_update(stru=
ct drm_plane *plane,
> >  	tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE);
> > =20
> >  	if (yuv && planes > 1) {
> > -		base =3D tegra_plane_state->iova[1] + fb->offsets[1];
> > +		uint8_t u =3D tegra_plane_state->swap_uv ? 2 : 1;
> > +		uint8_t v =3D tegra_plane_state->swap_uv ? 1 : 2;
> > +
> > +		base =3D tegra_plane_state->iova[u] + fb->offsets[u];
> >  		base |=3D addr_flag;
> > =20
> >  		tegra_plane_writel(p, upper_32_bits(base), DC_WINBUF_START_ADDR_HI_U=
);
> >  		tegra_plane_writel(p, lower_32_bits(base), DC_WINBUF_START_ADDR_U);
> > =20
> >  		if (planes > 2) {
> > -			base =3D tegra_plane_state->iova[2] + fb->offsets[2];
> > +			base =3D tegra_plane_state->iova[v] + fb->offsets[v];
> >  			base |=3D addr_flag;
> > =20
> >  			tegra_plane_writel(p, upper_32_bits(base), DC_WINBUF_START_ADDR_HI_=
V);
> >  			tegra_plane_writel(p, lower_32_bits(base), DC_WINBUF_START_ADDR_V);
> >  		}
> > =20
> > -		value =3D PITCH_U(fb->pitches[1]);
> > +		value =3D PITCH_U(fb->pitches[u]);
> > =20
> >  		if (planes > 2)
> > -			value |=3D PITCH_V(fb->pitches[2]);
> > +			value |=3D PITCH_V(fb->pitches[v]);
> > =20
> >  		tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE_UV);
> >  	} else {
> > diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plan=
e.c
> > index 2148b0c59815c..f4feec62ac023 100644
> > --- a/drivers/gpu/drm/tegra/plane.c
> > +++ b/drivers/gpu/drm/tegra/plane.c
> > @@ -319,11 +319,13 @@ int tegra_plane_state_add(struct tegra_plane *pla=
ne,
> >  	return 0;
> >  }
> > =20
> > -int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap)
> > +int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swap_=
uv)
> >  {
> >  	/* assume no swapping of fetched data */
> >  	if (swap)
> >  		*swap =3D BYTE_SWAP_NOSWAP;
> > +	if (swap_uv)
> > +		*swap_uv =3D false;
> > =20
> >  	switch (fourcc) {
> >  	case DRM_FORMAT_ARGB4444:
> > diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plan=
e.h
> > index e33a581e6490e..dba5f1b254e98 100644
> > --- a/drivers/gpu/drm/tegra/plane.h
> > +++ b/drivers/gpu/drm/tegra/plane.h
> > @@ -49,6 +49,7 @@ struct tegra_plane_state {
> >  	struct tegra_bo_tiling tiling;
> >  	u32 format;
> >  	u32 swap;
> > +	bool swap_uv;
> > =20
> >  	bool reflect_x;
> >  	bool reflect_y;
> > @@ -88,7 +89,7 @@ void tegra_plane_cleanup_fb(struct drm_plane *plane,
> >  int tegra_plane_state_add(struct tegra_plane *plane,
> >  			  struct drm_plane_state *state);
> > =20
> > -int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap);
> > +int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swap_=
uv);
> >  bool tegra_plane_format_is_indexed(unsigned int format);
> >  bool tegra_plane_format_is_yuv(unsigned int format, unsigned int *plan=
es, unsigned int *bpc);
> >  int tegra_plane_setup_legacy_state(struct tegra_plane *tegra,
> >=20
> > --=20
> > 2.54.0
> >=20
> >=20
> >=20
>=20
>=20
>=20
>=20





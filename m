Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB685CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AE510F26E;
	Wed, 30 Sep 2026 08:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UhHrbnL7";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A70F710E75B
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 08:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecrdVZTqdou8Nb3dHLrRB++6fSiO5QW8wkBxgtE13rdOo+JXF7Sm9F9DMhADkt8evARjiTmnjHyQn5GEtWVTBfkqNWZb2NtpFwJj5Oa1QBgIRSjePbgxOA90eRpuJvRQgJ7/pe8w6bRsGUb8hKvsxbAtvYDt4RBYUibQ0j6WDC7sU582pf8gku0oCLnjyRjvuz+U5PrBtpkhgBXO0ymJS8HDs/MjgbqDvyuR8oloQBXnSI3Wd3sx9RgBiZ9W69Nahf5q96kWiBwl0n7gHWlw63TqXdjTttVYdcHkSoXlBqIsVumcP3CS0sNNtkFAguG65zYIB7cikpcOkKLSqN83Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zu+bNPSzTw4qO/FYgdozGie5ME6YIGfFcvgLwgzuqIc=;
 b=BtxJ0GDCuPIpJ42qYUf+ToT3itb4CYcEtCY3GFoeT7CxxOV7nSQ5aCaQp6n8L74ISHLnCHSU3ilgwJf1uwC8sv6Q+yk3yBQDAi20eHXPb42Qqrh3XcQk01G6j9q0JTjLL6DG/vyJZByH6MBZXS5cuKCo/rBqsFgWgzt3DAT4LMuJHS+Svhvnb6uX7QMLZhGNvrYp+H7Sl+OWYLqktle3QTOqT5za9x59l4wBLd9w3uOZFqQ8llsOlQctgXM3QS42q8GcVSk5VOnHd5hL8cfuZREIwVTl/iA1Ly2cj1+MfwW6KbjqGxYf0y/SFJ9O+1SGVb4c4YMxFcJb3Oj7xPoZ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu+bNPSzTw4qO/FYgdozGie5ME6YIGfFcvgLwgzuqIc=;
 b=UhHrbnL74jbOfUocv2TmclN3fyd1sTiqhT2qeyHkFm4YsKTQJIGmSMFpBDki9DdaGLrUE0kD+JdP9eLrYCQGahCY53gNCqAgvaSesGgzI2cfkmRt8/aJaaJrDQ7wRiBJIepH96zpg49xEyrnVxyYGqmCdojJvlrMSga4uMdInaP3e0RLStG8sMbxUIL7H3Qg5x1ITxuamwOD1vsmfUcdKSmdsbe7BGNVhR3inNamTrkgm32zm7aiCOUnFvNTUAWg48LPIKMLZVPwSVN86m7mHlsd0+SahQJLVWlQwljyqjJFromsNpjWGNzX7M5I8q4/5oWD0aoGxuoMJY+zXshXqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 08:46:18 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 08:46:17 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: dsi: Unconditionally manage reset line
Date: Wed, 30 Sep 2026 17:46:01 +0900
Message-ID: <8pr0OOFrTHeQTZiJatWz_Q@nvidia.com>
In-Reply-To: <arzDId4Mxryrfa7m@orome>
References: <20260930-dalmore-fixes-dsi-reset-v1-1-58c9d12f5ebd@nvidia.com>
 <ary71zC1e-bySLFW@orome> <arzDId4Mxryrfa7m@orome>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0091.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::13) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: e169e84d-c48c-41bd-3f67-08df1ecf4af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|376014|366016|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DQ44+nDMwRoPHkVaT3bE/PyRco+ZG8zEQlXg+tH3B8BXB/wDADExB+/+njjierCnMv1fM1d1SPywBOOa3lhs6BmW3bZ+Syw4cCssITpT+HsBM3UMArbD1/6aSAOaQQHmCLVSFhuruJNLt67lzgBqVdkaTWv9uaYoXqzYh7Kc5KqF/ifwUeCZR0GwvDi3hton9Ye6gMNG65xnVqxYLayS8QHFEWj0RZIK+b5EaW1VtNpwpdi13RTyYdRrw0H9ESditnCfiSF3oWXwkEF3mbTxYnbrLEl+JULm4nipGt+gpUc3ic+W/LnysCbXTcZv1nqoLuRDr1XQD2PuEsC73/ctuoORkeb1xc2KYdB97cvu1J8wXLsxHRXNG4ZjW/1PfPhFes49VR8lK4YdBl3O2eBq16OCCA438Hba+H88Gp+SM+FKs7fnD/LZ0fnFn76GviLQwMC+aLIH+lyXFNu5csRkf6eNElNoDd+JsDdylvzTqnqGmEV8FUl85Q4oooSbr9nc6BjZzqtwa38J1MSGsFA50RT6s9okZz1gn01zolxMKBhfxREyts1I7xHG3x7s422qwCDclORzT00R36iX5ZRffEThm+7Kw+BBSpMNM7NorDRH1VGnWkkSKQQ+uGXjOeo9hWUoAlFwX91djRYvFEl+LkypCjVN6QZyvKoYk3J7Zzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y09KU0VuRXFyd0pvVlN4QnRCSjF5eWVFT2F4MU94RnZxdkd1Nnhub0JZbmw0?=
 =?utf-8?B?OFczQTdDNkVlRzE5QThZNkJCMDBTUjgyRVNtYkxndjZQU1R1VlYyNHNQbGZL?=
 =?utf-8?B?Z3YralZSckd1MUVqd0pOODRwRVFMNjV5UFlFc0FsZ0F1Mk55QWlvV3VxVkhp?=
 =?utf-8?B?YlRvN05Yc2xBSDd5WFBxcjZobTJUZDVPSTAwR3R0cGFlL2NvQzhxazgzeU9G?=
 =?utf-8?B?ejhTbk85UFJkYmhtM0tlZUE0ZGw4NXhrbjhxU3A2b0NTL1B3dEMvVlhFQ1FW?=
 =?utf-8?B?bzZRSDNJcVRBSTROSVhPd0RZVE5yRWYyMFBudVFPQ2NwUy9Xb3FxcEVyNk5N?=
 =?utf-8?B?QzJtZzV3Qmp3RlJnQjA3a1J2TU1IU3JqL3dOMEpOZnZ3bHd2d2Z4NnhZNDd0?=
 =?utf-8?B?cjBhenhDSU94N1JVbkJNSlFLYzgyM1N3Q1RHVnp4WUJyRUlFSG1GaEIxUHpR?=
 =?utf-8?B?eWtITmp1eHMzWWZaR0R6TE15TEVKNnNKdm5wVHpnS1E3aHQrdUh1SVpjVmJh?=
 =?utf-8?B?cHJRN205YzhNZHNZUWs3K2VFN0RobE1VSGhJR3hHOWxWMVJDODA1eFZUc0pz?=
 =?utf-8?B?NjMybWlKZjJJZjZWRGtheXlUVTFoZzBSWkE2TWdlQTd1Y08yU0l1a1A5dG5i?=
 =?utf-8?B?Q2d0b1gvMHlIUkFvR3RNM3RFSmpqMFhUZFFHYkV6TzhPZ01MZUlYRzJ5cmFl?=
 =?utf-8?B?UFZobUxta2J2TCtObXI2STlLUm1NT2taYmZtaURwaTVSeTRjZUJMS251Qk4y?=
 =?utf-8?B?M2YwOTJOdDJsd05UREpWVExIdHRSbG16V3pDUTQzendMb3VnSjhhRFZvUzdx?=
 =?utf-8?B?RTJOYlFUQWRFbSs1Mk5GRkJFbDRXMEJ1dUFFRmFteTVjdnArdTVCL3FFcWNo?=
 =?utf-8?B?SHZxS2pxeE1vcXM3NTA3Qjcrb2c2eTJOdE8zN3BOWW9ObUROVTBkNFhVZ2VX?=
 =?utf-8?B?cVpoajRHMWQxZU5nVU9Tb1ZXSS92UWlLNGJORFlDdW43Mm5YZVJGSVh6MUpF?=
 =?utf-8?B?SnliU2ExY2h0Q1BWcldYR1hIVGpYRkNQd2pPR3d4VFhFRVg3ejJwSEFFMkw2?=
 =?utf-8?B?M0s0QmRlcU4wT1Z6bWFLQTVucmg3Q1ZxR2RSWjFyOEFxVzBOVW5UVlpRb3FL?=
 =?utf-8?B?MW9MaU84K1pqa09jak16d1BkNFBSUlpXTjdTd0JUMHpDMnNvek05TzdidGlL?=
 =?utf-8?B?NWdSczNMelpNYzdQUEZicWVyNlByeHM0bjZ4YlBSYTlqZGNhTGpVQWc4Z1B5?=
 =?utf-8?B?UVdGalI5bWVjZkFVeGQ5YlN5UE9Na3E2R3YxZEdjcVh3NFczQ1JKczB2aUVr?=
 =?utf-8?B?YTN6cFk2bENMaUcwU0lGZkRYeGhPWmV6U1VFOG1CT0VoWG04UmJ6dWxmbjA2?=
 =?utf-8?B?bnBNY0hsOGk0dTNGNkFHY1Mwbi8xWVpsVlFScm5pN1RHNURFamthbzNTVHpE?=
 =?utf-8?B?emFMNmFhdTgzOVIyR2kzaEtOUTg5WlNydVk2RlBLZlJ1Zk5ZUm5nU0VtN3NO?=
 =?utf-8?B?NGhNMVlhcmRGWXhGdVBVdHBTQXJHZmpLTEVESUVvRjlYY04ydGlseVZPNEhw?=
 =?utf-8?B?LzZxN0d1MEVHVy9PSytxaVl0MXFFR2xyYnV6Zlp6WTZZdDQ5UEdHNkdISTlZ?=
 =?utf-8?B?WEc0NlNTeXQxTGJrdmRQM1FGaFFtRnAxc3JKOFJsR1d5YTNoMnpyMTZ5VWJS?=
 =?utf-8?B?K3A0L0lsT1JjekdDa25Dc1d3bGFCNVU5TmpDaHYwUDZCZ2VBQ3I0aXA3UnpK?=
 =?utf-8?B?VjZ5amhsemZRQ3VCV0RLK0dMZUorYUJZVWRnYmdjUUNucm04aWtlV2pSOW9K?=
 =?utf-8?B?MkZteVkrSlRPc0RuN3NYUjBHWTJLKzZpYWRuOE1adXhFSHJqeUtmN1hUWVRL?=
 =?utf-8?B?UmpUcFZSMEZTTzlwci9oNVJQcG9EOTM0TGdNbzFKQXB5bjF0a0JTdnRxYTg0?=
 =?utf-8?B?Kys0RnlaNVY2aEs4L0c5VFhPbHlIM0F4WG8rWnhrNE9kRVp2VkNJWktDSndF?=
 =?utf-8?B?OG5VM3JRQjVIY3J2QnBvVWJyQmxGZU43ZFUwS3VDQzNFdFVrck1wV0xrL0FB?=
 =?utf-8?B?d1cvenFwME43RWxodFpGY3dIU1hNTVBjTklFRUlJM2x0bngxZGNNQzZ1aDJt?=
 =?utf-8?B?RWZjeFQ0SjBqQmtrWVpEMlFSdm1FclhmVnZYYkIwN1B2ek5NVGdQc3VhV3Yr?=
 =?utf-8?B?WWhnei9GdmsyZjhqRU12NEZVVTRHZ1FhWlMxdUJNWm9VUGFtbE1Bd01IQlRZ?=
 =?utf-8?B?MXZ2QXl3ZDhyeWFrdUNwRGtJTzNzSUJZVStiYUEwSlFkZm1oYm1YTGlCTi9S?=
 =?utf-8?B?aGhjcmZnU0duMDFkdzVhMUhXbFpSbmVjamlzNW1SODFUMmc5VDJqeUtSbUhK?=
 =?utf-8?Q?i1ae213AwsAwOlbC3L9t1L8Iw5CZsI6KbpPgkqnXlXF5b?=
X-MS-Exchange-AntiSpam-MessageData-1: Bb6QeJbg/Cu3Pw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e169e84d-c48c-41bd-3f67-08df1ecf4af0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:46:17.7229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGQdQxs5jpiSpgltO4FoM0SbJ55Qst6iDsaxHhKhdVRtgKaZWLoNoRXjUotXxjEgW3I5xWlmpzEzmCgnQTQ6rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606
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

On Wednesday, September 30, 2026 5:29=E2=80=AFPM Thierry Reding wrote:
> On Wed, Sep 30, 2026 at 09:40:51AM +0200, Thierry Reding wrote:
> > On Wed, Sep 30, 2026 at 01:54:55PM +0900, Mikko Perttunen wrote:
> > > The DSI driver ignores the reset line if a power domain is configured=
.
> > > This was originally added to support Tegra210, where the power domain
> > > provider has to control the reset line -- at that time, older SoCs
> > > didn't have a power domain for DSI. Now, however, they do with the co=
re
> > > power domain.
> > >=20
> > > This happens to work on most systems due to DSI already being out of
> > > reset when booting the kernel, but on Tegra114 Dalmore, this is not t=
he
> > > case and causes the system to hang during boot.
> > >=20
> > > Ownership of the reset line is no longer a problem with reset
> > > acquire/release semantics, so control the DSI reset unconditionally
> > > from the DSI driver (possibly in addition to the power domain driver)=
.
> > > The device tree bindings already require the reset and it is present
> > > on all platforms, so this is safe to do.
> >=20
> > That seems backwards to me. The whole point of doing this via power
> > domains was because it's explicitly not safe to toggle that reset line
> > outside of the powergate switching sequence.

If you're referring to the MBIST workaround, unless I misremember, it=20
doesn't mean the reset cannot be used outside the powergate sequence,=20
just that it has to be used within in.

> >=20
> > Also, the power domain code paths are supposed to work regardless of
> > whether the DSI was already out of reset or not. If that's not working
> > right now, I think that would qualify as a bug in the power domain code
> > rather than the DSI driver.
> >=20
> > Shouldn't this be fixed at the powergate level? My recollection is that
> > DSI is tightly coupled to the display powergates, though it's been a
> > long time. Do we maybe need to reflect that in DT? There's a TODO in
> > tegra114.dtsi that seems to indicate that we're missing DIS and DISB
> > powergate implementations, so maybe that's where we should start to try
> > and resolve this.
>=20
> Looking at this a bit more, pd_core doesn't seem to make sense for DSI.
> Basically what that does, semantically, is claim that there's a power
> domain responsible for powering up and down the device, but in reality
> it doesn't to squat.

Doesn't that reasoning apply for every device? Technically, pd_core=20
corresponds to the core power rail. DSI is powered from it.. we=20
certainly haven't always had an expectation that the power domain=20
provider handles resets for the device.

On Tegra114 it looks like DSI indeed is in the DIS domain so that would=20
handle it, but on Tegra20/Tegra30 that isn't the case (even if those=20
device seem to be working right now anyway).

>=20
> Does the hang you observe go away if you remove the power-domains
> property for DSI? pd_core should probably be removed for both display
> controllers and HDMI as well. Probably also TSEC, though the TRM isn't
> clear about what power partition that's in (probably DISB because it's
> used primary for HDMI, which is in DISB as well).

I'd expect it would go away since the reset code in the driver would=20
activate then.

>=20
> Thierry





Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505F606A335
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MKjSeZav
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A0D710E43C;
	Thu, 29 Oct 2026 16:38:29 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E78211245C
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 16:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiMB7aLxEYHYHWaxa5MubJOz5mpahzw1ZlZYRNMBK7t8GsHBPfYhiTKf36bm3/T77LB2BOyQfH1IuFD9A0RE1hhRyciXk98krjIf20uiVuO82p9xJazaoroAobdAG7j5ed6jHJNgvFKYx/8yrxjpO5b/VusBM20oc1YY4pLH0IkK7QchONklDUU7Rc9JNx80W3N/L+OF4ZeYxXkCBaACJSJaIi2JKs+ptoIkYGtQ2MLHwV8SDiZXpd4GwloBNkAFvieza97kAcWO11R8CJeX7VOsH08PPF1yJlu5+cMBlx7lPJ9dNu5qtcp/vIbHunp66iKTM2tIbQFZgBGDCWNRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS5w2MxkVcisEnmlDwbM2WgGmsF28i8wLsmkOVo/TuM=;
 b=SYUpEc6xY8orRwATDHvxYD3+Rw6AXPan4o1o7U6RcjgvDpun66wqZVpJrHtRyrqGg9pK0mo6cdFWRENGRN261GPcJpj3q2BuJNILMJDyp6KiKVxfk3HbJ6+u/oQ+5w2asd/60XckB8gr7vEdJ9VR3sNhwyOVdsy6WECSWqYgbFHBVv6LwR3nvWLLZoYDE+XruYe28PU6oeydJHt7tJEKhpSYSGIANZMjWIb+nbObtYtz09PTu0fJeJ1DTWjIIKExa9fOgTyQYcvEtUSEXHG6/5RzOZ70Mh+U1HmOad7Jj66fvMbH/N6ZcqwjZcwILGiwUYl9/SS6ay+9GDN/TMbDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS5w2MxkVcisEnmlDwbM2WgGmsF28i8wLsmkOVo/TuM=;
 b=MKjSeZavwE0mPofgqzxhBHFLVAVuSluY+aGGTG3eHCV3RtIV30hxKFJs+B8ax3TQf6B+gz1agRYYcRLqOmXBjMhZopjPopwwSO3EZBZ+HSW/+VOBgziThNn7a1yUIxCcgkSNXHef1ND0e6QnhJx0dGEqP+sVlghr1m5W6a4kdxZcjG4vW/yt6YKsKXOH7ZJHMABPpW6ovvpcruMltWZ2coIk/eTz7Rn+y86WtgRDrRISpPu+bfcIz7Vqm6fTmQ31k1GyykflZCu59o5E4vUkwWj129MqOpfMK+WLSQ3xwZG57ZMymiU0kHFrWezbgVqGsAH8r7A0uHeByq6ZD2gl7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA1PR04MB11034.eurprd04.prod.outlook.com (2603:10a6:102:483::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 16:38:18 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:38:18 +0000
Date: Thu, 29 Oct 2026 12:38:11 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/31] accel: ethosu: Fix runtime PM get error handling
Message-ID: <auN2c20fmWdj1vtu@lizhi-Precision-Tower-5810>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-6-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-ethosu-fixes-v4-6-4aa25e22578e@kernel.org>
X-ClientProxiedBy: DS0PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:8:191::7) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA1PR04MB11034:EE_
X-MS-Office365-Filtering-Correlation-Id: 4044faff-87b5-4479-b4a0-08df35db09bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|19092799006|11063799006|4143699003|56012099006|261009223027099003|10067099003|261026121527099003|261021121427099003|261021123027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lm/CJvNJRSiI6msyBdvtiJ7snW03PQYI6DQTgT4How2PI3kb7u+BywJlA3/CkW2+y4z/ird5dNEkJ6B+XTO+wnkdynMWCPyJMJP3RbgdSqqz0H+s7TPUC/F5rcculmWTWWrvMPg+sik2rvGgXqVLK4cTdIxw2xJexkk1vz2WZhf/CfWlTQdoBiZ3chvM8sfkb+YDTUd1p1IeHpoqnOqc8TUdTLR0VFEX95k33SuMG21VUCkZjJOAn+rVdKnazNYPnd5E69ROO1TvseBgRwpCacOnqAENCK+e3is11KgfKpV5ePbtryz6OKxRA/5/u9Jyty5TFlVAq2LcSrvTNzfyo80Pi7XLRugSNbCZQCm+z+0OqXgwBVCo13n3fcZmHGbLRM1XeOjVI2J7GetvENo6MUSQowpbUOy+Oa5ievNOcbZy6MLMdvDKFrSu5R16LMX0ydQhjAlsIj0tZOx5I4BxewMHElaxWoceLyb3+gwxVHEoWpHRiysKfbSKPuUieJOcIZqtZXzOGClizfHTnywuyaS1gWb6H0LOoTnzVVQ/qAK7IkIZUZoEixQYJ70N1sQGr/W1t0ZUhtaSf5AY8xiEwOPvn344UdulHZfaqjQ8taM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(19092799006)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(261026121527099003)(261021121427099003)(261021123027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XO+W7YpMuj1/u2MbBh+3K9TLD50c9/5yGeg2AKQIzEnHB4tHmFCJHYC1m8im?=
 =?us-ascii?Q?4HJ3hP+nO29AuucwNpJb2AkKFb6Pl7KYJYPuaGknSHsnPSncFuYPwz+AAS+n?=
 =?us-ascii?Q?rRcWlzHR2qO8Nez6CIRqTFLF8D/8xpKgjojja+gVWbGmIqu1OCBYpipAOELd?=
 =?us-ascii?Q?z0DMyjikOt6iAKIZ4D9ZrgGO2MgJeBGZTM9PMJJ2iJ+Prb75DzFQkwsyNFse?=
 =?us-ascii?Q?QFaqvzIJFrI94OPK1RCaonpMpuEQmmp8jVKZdbALOsLCBuc46cS52EmRCQXw?=
 =?us-ascii?Q?wWNCLsCsqxPH4zsKfYyRhvgyAQOYq77GlXJF3bAwGt1T+FYKOQJafjIiGhRn?=
 =?us-ascii?Q?oft1XJNBDCLFWia57XaQgvLGhxtIlZFPRhuP0vMgPeK0VS+dIE50Qld2Cncx?=
 =?us-ascii?Q?UpuO+3lhYqQRQ6mj2v40W0qrcMIbtBp+mlIizJMy0wNkrLdVuC+sB+I/dNEk?=
 =?us-ascii?Q?+hCdH01WYIclwQaHfSv0mBD+8v89f+w3/qAk9UCtd8A6wE48XNkpBVfBgqKq?=
 =?us-ascii?Q?m1fot9usnnaf0fj/8IEwJqhehknMo6+KvjyVHWds2kWL2XJxfEBumeEp9Kwj?=
 =?us-ascii?Q?s/lCNJCcMlvCpxz/RS9ZIyUUT5jZeSEDfOd6JBftCLchcNK4e7iD0y70tKrG?=
 =?us-ascii?Q?uTpoD/CKAX7GxnN6vrEjQCzh5uT5h8k+APeKHU5IVBUweH/dtrrs5nMatftY?=
 =?us-ascii?Q?znP7JF9DCazF7YZsINHSVmOGjYJRH5tjlDLPuOJvI0ruuyZEBvcYxnrsF9gn?=
 =?us-ascii?Q?FYNM5somCSTl+yPivQkv3YQ9Y0Y3y6+vZPCXeW97s7QyAKqPE+ezXTSKlgfg?=
 =?us-ascii?Q?BDnp0dG3XGCWMAwtr0kp4OrHQwBCS6iruh1+6+OAd18Z2vhKrZI2/+7/ska2?=
 =?us-ascii?Q?2Rm7++KVkQzNLxKhQOmaGyKJL/WEhn7CIJcx8oQL8sAhWzhGYi6++J3Rj7QK?=
 =?us-ascii?Q?Omx8fNOv6wK4piOtjSfNSbhkAtQFycnVnpWgPrzZpnQmqNiSD7AG1ZmNBBtE?=
 =?us-ascii?Q?bmi6LhjV3XXAMz1hiYwm2/qV603fuYfUGB7gsyDBdpRR0GE0lt6jEoQOg1lf?=
 =?us-ascii?Q?C9Jn2W/+UFsmiVQoUBuqlbhAE4wRWR/ZY+3SxupXTaNyCwa/Ap89yJ5Fs6N1?=
 =?us-ascii?Q?/aKaElkE3ub7R/2jvNDxp26HDK4uyG9hQaqwyWkMm5XmG59er+IN8ZCe9mYF?=
 =?us-ascii?Q?2FpCSrdqHQLvff00R3CXEYPVuBZ0rG1ThUoCAhhjlooZEOqHUrpYsau3TT5X?=
 =?us-ascii?Q?eNHhKv0PQAMqqHYdbMedJ7z1TpjGYkDj97p14TjAIJDHHdSUWbuIRnnO2ua+?=
 =?us-ascii?Q?59i6oUM2UHV6WvB2OPBlz7jpNNM+E3n5kF5eg2tqRbbQPZDOYqJwAp3K8VXl?=
 =?us-ascii?Q?0ZHJNvzqqFHdIsD5dEiNypCHnR+o9SyT54tS7qyHUs9FpzkXaF6K77fF03Tv?=
 =?us-ascii?Q?JihEfnyX1t5Fxx3RV2ohfAzbv1CAc1jTJzV7d23uXJzd7rTJpmnGtyiz0E84?=
 =?us-ascii?Q?CurPJaw5Ylhh995OBAIC/1XdtFdIMFLztDnXRBmQCbOTwNFrU94BpOPXQ1N5?=
 =?us-ascii?Q?QkcCSyZ3uxPCNT4o7Ti6OSgV472n8Gq0ENtcDNljjfq3KTa4ZZBz7eEyjiyu?=
 =?us-ascii?Q?2aP5+gVEQstPfVkWxgu6VFuuaSr+XIzcgRoTwObzBTHmUMn/EoWN3j/iL3d+?=
 =?us-ascii?Q?Y1NFbz3/yTNIygVquDx3T9rWzJ788DfB9PXGOkrWFnHQR2A76OvEKKq6NTis?=
 =?us-ascii?Q?gg5dr9x0v/51vwq1zyOnUqs3FMlv6xbEJK7m7Qlzft/iOWZOvS62?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4044faff-87b5-4479-b4a0-08df35db09bf
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:38:18.8305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlggWKS850LyVVuPp+0n7153rzgwYlsJn6fgExRw+lsmLCxazEEMP943VuxT71jHbEi6Z2FKy0qn4MRrva3oO2gqtTJENECqjBZBzUKkU12IVnv6wrz96P68+4D6ZvNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11034
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 08:35:53AM -0500, Rob Herring (Arm) wrote:
> pm_runtime_get_if_active() can return an error including for !CONFIG_PM.
> Do not treat that as an active runtime-PM reference.
>
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v4:
>  - new patch
> ---
>  drivers/accel/ethosu/ethosu_perfmon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/accel/ethosu/ethosu_perfmon.c b/drivers/accel/ethosu/ethosu_perfmon.c
> index 26f625374f9d..0ae2df3ceac8 100644
> --- a/drivers/accel/ethosu/ethosu_perfmon.c
> +++ b/drivers/accel/ethosu/ethosu_perfmon.c
> @@ -71,7 +71,8 @@ void ethosu_perfmon_stop_locked(struct ethosu_device *ethosu, struct ethosu_perf
>
>  	ncounters = perfmon->ncounters - 1;
>
> -	if (!pm_runtime_get_if_active(ethosu->base.dev)) {

This should be correct. I just post
https://lore.kernel.org/imx/20261029163044.3062958-1-Frank.Li@oss.nxp.com/T/#u

belong to Pattern A

Frank

> +	if (IS_ENABLED(CONFIG_PM) &&
> +	    pm_runtime_get_if_active(ethosu->base.dev) <= 0) {
>  		ethosu->perfmon_state.active = NULL;
>  		return;
>  	}
>
> --
> 2.53.0
>

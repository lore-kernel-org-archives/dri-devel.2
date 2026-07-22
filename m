Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590A8C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B5F10E4C2;
	Wed, 22 Jul 2026 17:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H29mDVGx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6BE10E0C9;
 Wed, 22 Jul 2026 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784741267; x=1816277267;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/Vt5yPkRCn1CbqddGuGpGLFsR7eZ+AqBYwaGOTnsJ7U=;
 b=H29mDVGxCJxQ7CgFGEl7dDcfOmd53+ugVd9KlBfW8vdiFQcxE8NJ7X+V
 14xh/AVmtZnfeXoCuoR37J0ODwLnCGcT/uXKoDZN7QPnKYaeC4GH7WNO7
 fZT1mrLyfYbjZC9bWKlPQCaaophktuu1xYAi5pUQVTAB3jECJ9ZWciHu1
 b5SFT7SZ4bhR7fvYeivw0phdGWcnheBT/PoMSjVV5RVmjSqtNE6TXXk/n
 UTuzaIs6uvbhkjwt6yNE+niWEWXb1ivxE1Y3IdyVBq8JTUOrqtnmvXT8X
 peoCIPoxm63QhOVQpQKuyliVFmm15TMbP7Ws4yXJnWrx5ZgKkbkwcPLBp A==;
X-CSE-ConnectionGUID: tCex2uKuTKKLU3iNfp7EVw==
X-CSE-MsgGUID: ab2ljSS2S+u6jy7V2L4jxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96900528"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="96900528"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 10:27:47 -0700
X-CSE-ConnectionGUID: gzIQeUdcT6K2ipX5GLfiTQ==
X-CSE-MsgGUID: 8KXvpdThQqe6PkmC9Kgclw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="263100001"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 10:27:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 10:27:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 10:27:45 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 10:27:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qU1yfPTayJ9HNqe+doGFf9QfzWXFAxQ+s3Uqae+Xdhplwr0/XCnhUoCFUb0su/atwrX/8i64LMOnBHFuslpzMs7vBuFPJtdqV9jukz6Houl2Mwh0AMwdX5zqKRH3kZAOxYnLFV7wmA8JDbN+4ecUgNye2vNxjv1bBOWzz6zcsBVVQb60/eLux+oq4EiP0/JKmyHh23OafSCS/wE4OqM1Q50zl16uq3JjvnDFMmf8iZa0SnTRjjmqgVLCmGkWyXkFL2B0Q5lSFGJoWXSWTQiIRBbnHKI6Nrdr21EnWYlgSow2M3x2hWpzS5Jti6aUbgAfn7iY5zzwQPX2QkMoUD8V6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZABvPlkU5WxFXp7+Dy028qneSP6BV6/roDF20D8dZc=;
 b=lRiYo2exSE1ITQ4ybGwrUvacRODb0Y2wATvvfYmNK4prjGViUDUdOKy/AV+/oBiTKrWxKiNFxV/R7h52yB36naU8sMqjXaBRL+8xXRx2d2Mgv6XAJ1smgWfofMy+I6iJkL518HbN75UiJ+1L/p+ogazqRHAT4chFGaUrll8/H5z08wsCGQZeQkEzuU+y9izwKZ0jACYC6MdCh69BKttWbSLfU5G00Y9EYcZy3jK4DOF4qHbVDaK26KrlkXbcwY6SW2Qw/RvNJWH/ttHuF0OpLQKdxmev8tBR5WgvXyFgpQg0CzvqeQHxQpbwo8vsxW5KYweZvzbi4Ucl0c9IHLvX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:27:41 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 17:27:41 +0000
Date: Wed, 22 Jul 2026 13:27:36 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <kuba@kernel.org>, <lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <dev@lankhorst.se>, <zachary.mckevitt@oss.qualcomm.com>,
 <riana.tauro@intel.com>, <michal.wajdeczko@intel.com>,
 <matthew.d.roper@intel.com>, <mallesh.koujalagi@intel.com>
Subject: Re: [PATCH v5 1/5] drm/ras: Cancel and free message on get counter
 failure
Message-ID: <amD9iLF1hTnYUEw5@intel.com>
References: <20260722034228.662746-1-raag.jadav@intel.com>
 <20260722034228.662746-2-raag.jadav@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722034228.662746-2-raag.jadav@intel.com>
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|DS0PR11MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 985aa765-c086-42a6-dbc0-08dee81688ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|23010399003|376014|22082099003|18002099003|10067099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: ouCP6958bPr8x+quiXkTMPfxayu6Zjx4EhYD0W6i12z/DXzD6sPtqjbQzmtv82JBtA87AuP6B125ZHsEGNcDkv46nENi0B1BuqJJ1tZofdghx8d3E88c/D+WHywrY0KBgB9zWbmLMulAcDQXG2nifEX1sEEatPGaX33qoyW9NZYLdfQ1LcJ+zIuFwXDiBxPChwpReRVP66bawWjf/1y1u3Zq4ESKsTCJvCcGqkWlRI8MkdgENl7QISvZZWaIbtsjPCVMoGOKmlh+Q4iP8BzwfNhxz/sW9bUUswPtm2Fy35T8/DwtYtpTGGyVpUVecRiWLzxyfG2wxxbb9E2TY6Yu+XfBLwZYEgHjYsM2HkN2xLJpr6pDJ1lJzFJe/9l+n5V9kRmBuTlfL+O13SN1odsDUYBdof54XbAY4xOF+YSwbc6DEZSO/UKbZo4a1u6jxAvhd2zTLBZ4wlSxuq1chseS3pc3JX6iRm9DdjMfIA4Y46npVNqNlZB7TDGqhwVCeQ2PiPlI4MflDM3fRqKoYkf5ha662V7wmr8yW5MmIQhahe8FMJuGaCMMTUzrFOC11znLa+2I4xLv8djZJiZQP+n3IkSOoDwwJG48aW3PhAMlaYYYpfcH7CSu5p7JJbvumQkBq98UyoSMzKqbgPsP2QyZL6FPdTc/BOJvw2tudiCw/nY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/6ydb5WXbsl5MEsCknwCxuZ0VTdZz/2uk7WtO7MCQFQRw1SK2W7a0SSIWMR+?=
 =?us-ascii?Q?sNY2wJxWjrBFnZ+s8cXF2z/wU4stLA8jwlKBIIo4GZz62OF9GOiTSncld6El?=
 =?us-ascii?Q?dmeVjQTTgdtJ2CNp6LqrD1tAM1tn5emDEV5wnbK2exjERegkffVV2CEeHcb+?=
 =?us-ascii?Q?Un6pru6YxIastBqF4nlVp7QiPfK7mDNUSIzZy9QCweV7UeND2Gt7jU0SLd/f?=
 =?us-ascii?Q?vseQ2ar0e2actXGezES8+ae6idQHCkJze/awPwgL7l/C8dgWsp9IoPENfGlq?=
 =?us-ascii?Q?LYid8U3dIYojV8cTGRs27KbRGb0lSxSn7fzneXykC/ndZEnHPI06re7Ooa82?=
 =?us-ascii?Q?Rg4XJsLucmQ+RybX+gH3TeS7n5MiRfAxeavJnDMentFSNhrsoLOnXSlylhBj?=
 =?us-ascii?Q?/os1UAWoVkwl2+Q6kpeK0XFO9ck0hT5nDIRYCOAQYw375cJp585iEIIU7JLX?=
 =?us-ascii?Q?nFwtdY80kqChWDio5M1bxxRLh6JGiBbqWnP32/wtlESgTN/Nplc9msjyEeR7?=
 =?us-ascii?Q?EPeC5tYjFbhydgZVqwBCZlRYxMVo5OpMJLQT5ft93BZDNbl5/VHGzSV4HGIO?=
 =?us-ascii?Q?hB2PZB/jq2YPMyJo8rI9odHTBgp2CvMucrrIxZHblmLvXtbDdJ+yC0MlZ1oA?=
 =?us-ascii?Q?9+pOwUR7juiqyEwyOSCGmwYIANQiBttKe5dFUOlWpNV4lvVpDLss6RBFndst?=
 =?us-ascii?Q?WsOGxDs87jkfSk3pjqPOV7Eno8Zz+HAHKfDIzGCkEX4Iy7TQdXuGY0KKTFin?=
 =?us-ascii?Q?+P5DQugNVFqYHHlaz5qg6KxwJRa8r8QyYZfz/7B3IV+NHIXCmdlX1K5k/uhF?=
 =?us-ascii?Q?MlSAJR+QrXabvRF4sOI4uA07QR4dVMeMm4QDzTnbPXCNZ8AKn9X3YjRBYpMA?=
 =?us-ascii?Q?cHPiMgHnCUh9y1DlK/t7RfqV0HVjDy/CTTjfz9AfYI7HIYB0yz5n70GscHeL?=
 =?us-ascii?Q?a0h4F4hU6QWylX6SQGILjTtHWKBRcVP3umJGv4eTgGT7CmV3RSjfPdO/F5j3?=
 =?us-ascii?Q?3SicZX/ooMdSKwim6z8aethOsrcqWXHjIFhRQ6MzblYnACeLBW8oOFqQ7p55?=
 =?us-ascii?Q?qcqKAzb4p0pcwq7q1rno9FSa9mXQRpstpnJXq/geaTQ7JL6XpPbN1C5cAQwK?=
 =?us-ascii?Q?VV3fbxaKAsZWQiIf/mHOF6s4roGwDYE2nCoiFCkh8E1TyRASFJd24PPekT8d?=
 =?us-ascii?Q?pjPT4V4UkvwqBAbFtNvjXw99n+Kvoi0kuLzNS8dYM9m74Ggo4vRd6ffaheCX?=
 =?us-ascii?Q?dcSZ32AZaJuHWSm/Srzgd2HtlS1fHOVWuK7+k3HMFSVv9HWV0fUs64zZXmqU?=
 =?us-ascii?Q?poBp+V2VSmma8+TJQK1qy6c5M7DNzo9maoZM6B17zWgUCsXCTPc219jWws41?=
 =?us-ascii?Q?Gj1GW3411S2aCpSiTpfe+5lRd7/ZVJzMDM5ZyLZfLAKst3pkLnhGnraVQV1f?=
 =?us-ascii?Q?W6AfqjHDjvBn5y6itGPMKbxk1iYeNcVacKBQiUn6xSoezrjxyqQ2ICHzQAGh?=
 =?us-ascii?Q?5d56mWDHYfOIkv7TTN34OV/J9+NyegReVLKZyHneDpXC+4BQFlSkNwvkFtR6?=
 =?us-ascii?Q?BcA1NHqF5qkd20Mssy6rYcuOe/OyOzbg+cAV7RE8HjbunhkgWx5RU5afK5tC?=
 =?us-ascii?Q?ocdzcpYosep2rJRfvv5Dy8NVOnpQqh9nxo9OdTB7O8mDJ7azfQfp2ahDcO7g?=
 =?us-ascii?Q?DCbURmmn+3GcjTVuRUYkyT66HNPt0THMdUMFISrLJpvmwjtzJBkfVF3Ae7JF?=
 =?us-ascii?Q?rNVZ360hFQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: lSzLd8yAT5kqBnwYnWLHcQc9YF9XnL8QfZzKcJg44XvsWYs7VtMgXPCb2iOBZ6QGq6ya/2WK64515sFq4TBlyasHQxgIZ7TUajIHlK8FAXkq/Ik6P2lJTbCoL8Kvzk4jD8Dt02Hltqjm4S5c4hNgq0Mnal2SBVibBx0c3iRxToKGEg2zgDj24Tb6RGaLqnWNWOC/CmUj4rcbhYeIzAjJErbBjMSfajLHbNItuFeN/0+2S2OoPoXsv9F0QtNwJLUBc2SZE5bXlKywjk8VVUoygtfcWXeFh/2kaCLGXX0sAkv8eGMoaOb1R77ZWpSA8RauqAxEQvf8bC5QBZIWWMLnWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 985aa765-c086-42a6-dbc0-08dee81688ad
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 17:27:41.6607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0Gum+wwxMaLCiugVS4FmtOLjMeil5HJlVChrB03+0ludQTWIjuqCjtM03DApORO0YvXK7qcaSyvBfzvEcU3Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7309
X-OriginatorOrg: intel.com
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

On Wed, Jul 22, 2026 at 09:11:11AM +0530, Raag Jadav wrote:
> doit_reply_value() directly returns on get counter failure, which results
> in stale sk_buff and genetlink header that aren't cleaned up. Fix it and
> while at it, consolidate error handling using goto.
> 
> Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Riana Tauro <riana.tauro@intel.com>
> ---
> v2: Use goto (Riana)
> ---
>  drivers/gpu/drm/drm_ras.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c

drm/drm-misc maintainers, ack to get this and the next patch through drm-xe-next?
We have a pretty active development of ras in xe right now so we would like
to keep them all together there.

Thanks in advance,
Rodrigo.

> index d6eab29a1394..467a169026fc 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -201,25 +201,28 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>  
>  	hdr = genlmsg_iput(msg, info);
>  	if (!hdr) {
> -		nlmsg_free(msg);
> -		return -EMSGSIZE;
> +		ret = -EMSGSIZE;
> +		goto free_msg;
>  	}
>  
>  	ret = get_node_error_counter(node_id, error_id,
>  				     &error_name, &value);
>  	if (ret)
> -		return ret;
> +		goto cancel_msg;
>  
>  	ret = msg_reply_value(msg, error_id, error_name, value);
> -	if (ret) {
> -		genlmsg_cancel(msg, hdr);
> -		nlmsg_free(msg);
> -		return ret;
> -	}
> +	if (ret)
> +		goto cancel_msg;
>  
>  	genlmsg_end(msg, hdr);
>  
>  	return genlmsg_reply(msg, info);
> +
> +cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +free_msg:
> +	nlmsg_free(msg);
> +	return ret;
>  }
>  
>  /**
> -- 
> 2.43.0
> 

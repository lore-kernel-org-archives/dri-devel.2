Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594D606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V2EuLXxv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC47210F377;
	Tue,  3 Nov 2026 06:29:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9DFF10F367;
 Tue,  3 Nov 2026 06:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793687359; x=1825223359;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=W8GD8nWaRdUBZVP5KwOl+HJMA80u7DMrWmBQxPl3zak=;
 b=V2EuLXxvXDzrDGGlSpnTyufvi783GKRSbACoMMMQfbJ/I9BnaSKPLyvY
 Ec8a06oXQKqVTmB3H4s48LYtUn2SdiqyfFgstdJ5Kc9gqap3VuUlFIwVw
 77McrSe0/Mcc9i4sB/BFeSB+6YjAeEMTxDfN1Etl/6xgRgJFueFFAyTFy
 +rqEZge/u2sWzLAy5LTBuuDzhyisKRqurGe669IpRdpcCPn10iDKWgWqX
 wQq2Eii7zS291hz/zOvULR8NF/Bxr+Hp/xiBnoPzvnGuB/tp2d3DDNwAZ
 62XnMCx5GYgt/oTCaFplVrw52lSfyE40Upn07UdbSMKvazKJjMBm6ODAo Q==;
X-CSE-ConnectionGUID: 1dqSi6OjTkmyUA4wtdEwgQ==
X-CSE-MsgGUID: ZxVNv4t8Sg6ADktHdjWjew==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2287608"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2287608"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 22:29:19 -0800
X-CSE-ConnectionGUID: Msc9eS7OQ9qocNtSt14WEg==
X-CSE-MsgGUID: 3TduFIC2Rgu5Ey7CfjHbMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6658996"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 22:29:18 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 22:29:17 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 22:29:17 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 22:29:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeA1TAApSaRLGq68vLGTP7nhiTkq2CyN3rtDoT1z0ZC5Sn/WSN0ppCp3jOJLvDoqVCBQtOIvPQDOxo00pCsWZgfcZ8eM/PnTDE6PSDTBRS5pcz3dXFJh1Jx9Er/k0m/ghzpb5an3LfEPn0Q13Kx9CTHwK0j6e9Mv8yQS5Tn+k0NrzJ1oIGDZHI5whr6GQBvg9j5UyhtxvIRsqQhCHE0F0xkd/7R+fViISc0I2XPmbFiD7pb1P6TvPez92srxwf4oIwnqaPEHfTey/I3DpaANRymjqf2zT/ojhNiIoDlZQ1gdVobVIfXQPslIc/6vHFhmA9v30d5YcUb8NkVPG47tMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp16XAy/tpI+Ee0lOc9jQcu8z9eNKziOEEj+EQoNWEI=;
 b=nRLES9oZ7FotKchECHsEY29qU1O1ChSFgFzKMVWh9svjhxq7Kg1sdT8qZE3XLDbvKUmk29qWi4M7e1kY5SLkL8/U4V1R4zenfs8WfP1YW5eBObayalXFPme5v+vLA4anvzk+3kxAWmvd5oCNGD0TsIdb0ZzYTbikQgrZgiTx00hcSxGfjjDbUopS9r+E2pzcVi6JPCN/p1jxdC2DRY7WYWkgE5NPWtFSdnjRwwPazjr3MqoThX0fdSW853p3xXQIbkZPuzMcKk/YtuMkcgQHrdE/022n9j2X4QXnqtvpIdlicUqJVrr4A3hmBDhlG8htqTfwbnmvnZgFfXY7FtYmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 CH3PR11MB7204.namprd11.prod.outlook.com (2603:10b6:610:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:29:15 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:29:15 +0000
Message-ID: <fbed8ae3-d292-45b3-9feb-96d6de63ac14@intel.com>
Date: Tue, 3 Nov 2026 11:59:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
To: Alan Previn <alan.previn.teres.alexis@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Raag Jadav <raag.jadav@intel.com>
References: <20261102222643.1758080-2-alan.previn.teres.alexis@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20261102222643.1758080-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0082.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::12) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|CH3PR11MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: b34a6316-a9a3-4ff2-70e8-08df3973c828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|261102123227099003|18002099003|22082099003|56012099006|11063799006|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|261009223027099003|261026121527099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: in6cF/owAUAuic8+kh1oQdBl5jaBbfynUs6EXTDJjfDGI3wRB/5VEImOqpJnUhdsh0WO2PbAJ+e4xgp+RQcVrjpYRw39N3CLvPUgzQ54Adw0HrYyUy0d0qDk0l9UCjC2AdWk2JTX14l6GTeriu6L4uZReiwoSRk0OOyQfKG9oidUYc8rmF+guJhAE0fe2jZBPOiVF6cgmtbaHQMEg7Mka3/TMdwYTJRBFpGw0xGqtbBNn4BkSpmkciXcOCPFNvT1fcqn+E3HxT9FrUXvL4JqYYWWIY2dq2qJn3N2yaoYPFo8QGYgGhXLTc+xNP4HU5umfpLxEGl41zM1KB8v20abVB1zsVwbLnhA//YGyWeD4Hp5230muBY8zNzPLVCOn3SYfLcL1OEWvwcnS4SSpnyl9cWj7YRq0FEqrJyKlzUTykYn1E3qwucYqiT9biaI7Pj0sBi+lmNixtNRiBvadRt87NpQNKYx9sbL6CseeNhI73mZptX2El1d9W3ctD6ivO61fcDmbw11BfIHn+lNobn6wpA3GPongyMwKUS+7p/Zn60PewhTyqCAB8jIkCrHJbPxK44ehIYjIS85j0Eqc5xbC/N63YHi++TsilYYVGZU9ki58M1Rlyj5UBKymyYbiX8hB0T8ZQHHVZgM8Z9uXlMmeGxHfpD4AlQB0KPaCkJOFXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(261102123227099003)(18002099003)(22082099003)(56012099006)(11063799006)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(261009223027099003)(261026121527099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3ppaExvUXRvQXNWSW5PWGVGR3FDSnZVZVpxR0NwSytYYXpMcFVOUzVMUklC?=
 =?utf-8?B?S1MzTDJmWHFMcWYwaFVpM0gyd0toaEZTMTJ4MlR4eThFNXBQV3ZIUVF2Y1V5?=
 =?utf-8?B?LzczUzFVSC92VGxoRjZBVHFITWozMDJNUGdoeTZnem0valRHUjZPdmVyc2lV?=
 =?utf-8?B?UW9nVkQrczZ3Lyt5dXQvSmkzd2dTL1ZDUnFGOG1sVjdvM2k1KytrRmpaU2JH?=
 =?utf-8?B?V1NqWkRTZUNnSWtsb0ZtVmIvOFJIUDFpL3lzbDBDSXdVODNaL2svcjFtdnly?=
 =?utf-8?B?RHBNZGlMZVBpVWxodDhraFozbTJUZnRaTjJRand3djJra1F3QjJNRGlQbDcw?=
 =?utf-8?B?Ym9GZ0wvMktFK290Q0NRNHY0K1hubExSczE1b29jc3IwU3QwNmtFVjZIV05w?=
 =?utf-8?B?cUU5bXZPUVhFS3dRZk5Kb0krMElrVG81S055RFFxMldJVTNsR0NHd0phbjRW?=
 =?utf-8?B?MGxlMHRKOEg2U3ZZZnZtbmdlQUc5Nlc1S084aTd2RHpydjkrZUF3ekhrTWZ0?=
 =?utf-8?B?UFFBd0pNd1FWcVl3RDJnT0xIRkpaemM1RFBIVXhaTURGUU1FMmFwZ2JVUldZ?=
 =?utf-8?B?V21jOUdocjJsdXZmNVBvbHNkL2hURy9qMWlOckE1VmoxektueXc1R3FacWIz?=
 =?utf-8?B?MDQyZXNBYWxyNERYMnB6L1JhWXhpOEJOTVQyUnVKbjNpdWZucCtLdWVpMTVu?=
 =?utf-8?B?Z01wYkFVc0xuaVowaXBGQ2dsendWdjZZcG1KZzIzOWtEU3NycVBPem81dzlG?=
 =?utf-8?B?R1ZsRTVINmFtVzJhYjZCRzBXTlVSeEhqOGhJTGd3QnJPeWVWbmlPNjdOL2ZZ?=
 =?utf-8?B?U0Iwb2N5aXQ1QWJDTXRheEtPSmNGTnhkVCtxWDU5S1Q2NmFkeUM4L1dhYnlr?=
 =?utf-8?B?NU5PMWpwSENaY3U2YU9xaEltTWhjdWp2bXBVSWpmeFVMdWVueUpIb0ZEdGFX?=
 =?utf-8?B?N3Z3dWJzc2EvbXA0Rm9Wb2pETEordjZyUFlmUlMzbnd0dE1aUGRGUndtR2FC?=
 =?utf-8?B?d3NQSXhva0pOTG5BNTNPSlQ4Sk13aktZbkxjU0RZUVNXZHB4VWxxeUY1bUs2?=
 =?utf-8?B?bFhZY0hoamhyVnd1WjdXYURKdFJ3aUlFdm53NDdYdTQwcFN2bVlDc1RaNTRv?=
 =?utf-8?B?T05aekhub2R3MGRtTE5VRVV4MEpoL2l6SURJK1NFYzQyNjJoZEk3bjdCQnVk?=
 =?utf-8?B?Y08raVJLaVNrZmR5c1FyL0YwMTRaRUhLM2s3QnpnL1B5cklaL1BXTWtlTklh?=
 =?utf-8?B?UUlIN0ZEamJ5dDZaRHRnd1BNNHl2MFdqRGl3UURuTWpoK1V1NjViY05WK0ZD?=
 =?utf-8?B?cW5RNzA3eDYzUnRjOFlJc3B6Q0xMb2lleW12cjVpZytvMlNsVEdDV0VFRHpG?=
 =?utf-8?B?VnBBZjBaOG9aKzNoR2hvV2NaUDFqZm5DajZNdDNVRDdtbVJWMEVnU1RqWHI2?=
 =?utf-8?B?RVBzZk9mTEVjZlpxNW1KOG9wcTVjSk9ZTFIrR284SklKVEhyNWlZV1JoYjBY?=
 =?utf-8?B?bTZEMDZGVGVISE5uS3hNQ09aMTVVaWhUNnNjalFsUVhucUZkQ1grdGFDaTN0?=
 =?utf-8?B?RWl3R29rZklDR0xIUnNaY0R5OXBFaHpZbWx4MjFwci8yNDhKOCttRCtFcG9r?=
 =?utf-8?B?Qk5jTHBRRXR1ZlZpbHZmVi9DWVQ1eWFvOFQySnZrZldXQlB1djl0dHY2ZXRF?=
 =?utf-8?B?SEQ4ZkNnazg5WVdURldiRDFqVDJhclhlRVNnM0hXb0JZZEpyQmJrQ0dla1l6?=
 =?utf-8?B?MHZ6S0pETFVBUENnUWZlQkErSmN0TXkrTnZvRHJtUzBkcmN2eDNNWFgzcmEw?=
 =?utf-8?B?TFJIMDRsWmtORE9VQXozSCtHeW84VFg1WVF5aXZQNFdPSnR4eGM4NzZBVWc5?=
 =?utf-8?B?UzNQQnQ4LzVmalJXdkZ5d3ZYVjBhQlJYMU52WE5JR055bnk2OHU5eU5HWmg1?=
 =?utf-8?B?K3dvU3lHTVY3cURwdXUwdUY0VzN2TVZXSGpNVWpTQWgyRWpuOTZqaWpCaFEv?=
 =?utf-8?B?TVF3VE5IYm44dnFDcFp2QVZtU0hRQ3pQVjQ2eW1HVGVwRDlZbzNtR0U2WVd1?=
 =?utf-8?B?dDJQSlZLRkVWRDBmZGRZV285UU8zdk9XZktpUWtBaTdvWm1qYnZhQ3h6UzBZ?=
 =?utf-8?B?WG94YWFvelJmWnV1ckFQY0tzUDlEU1llZmF3ZWxyNDVnVm95VmtXcUNnb2Yz?=
 =?utf-8?B?UVA4VmRxY2VSQnFidnFUOC9VcGc4OWZObk16T0JCRUVjb3M4NVZFTncycDVM?=
 =?utf-8?B?YUtaTG5LTXVvbWlhL2N2bXZ6Zk5vUlA5RmppK2Z3MUhYSDZmV1AxOEVnMVFu?=
 =?utf-8?B?T0dvbGdlR2E2SUh2RXZ1cWNrUk45ZXQyZXNrcVQ1QkR2Y281QWE4dz09?=
X-Exchange-RoutingPolicyChecked: nNbM01PzmGYclqL6OksVVL32QtpjkW/uoyWb+sKumkIQHilAeA+DT7MSZlMAdATtZuEdHMjlURaVVdtBv804X1DoHzjWCkG4YWpcYWihnxLUEBWMXTuRSym0c/FXeFJxoMtwbYlhiXJSiYcmzBMfoDuIoCg60+1lFGWH7ZslPOiRbs1I2VxTOQii7N2t+mqRbjeBumclatKAZsJjNOhhkV0+N8HVN/EffU7bx7+rYiXCEjpADRjH8HxWs4M+MJ9+jv6k7TiJ1wImqmRxKv+z6Rl9i+dGf5XrRND87FWcxN7/9hhRMwockOZtnFSuifYTHX4Mpw2NStp14/wnkO0rqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b34a6316-a9a3-4ff2-70e8-08df3973c828
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:29:15.5529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XPiP2MjvLht1y/qJlKmnV04nRKS/8bDdWTum1KlsQskIZveeQld0CdJOd2tlZwZPzbVy60/GT5HGUOCsneZDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7204
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 03-11-2026 03:56, Alan Previn wrote:
> When user requests to enter survivabilty via configfs, or if
> check_boot_failure is hit inside xe_survivability_mode_is_requested,
> no indication is published. This patch adds some awareness in dmesg.
>
>   v4 : - Remove logs from enable_boot_survivability_mode to avoid
>          duplication (Riana + Sashiko).
>        - Rename xe_survivability_mode_is_requested to
>          xe_survivability_mode_is_required since it checks fw state
>          on top of configfs request. Refactor to avoid duplicated logs.
>   v3 : - Limit message to xe_survivability_mode_is_requested. (Riana)
>   v2 : - Remove / modify messages to reflect underlying behavior. (Sashiko)

version history should be moved below ---

> Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_device.c             |  2 +-
>   drivers/gpu/drm/xe/xe_survivability_mode.c | 46 +++++++++++++---------
>   drivers/gpu/drm/xe/xe_survivability_mode.h |  2 +-
>   3 files changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index 07a7ab6ac083..608309745328 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -735,7 +735,7 @@ int xe_device_probe_early(struct xe_device *xe)
>   	 * the driver will be blocked
>   	 */
>   	err = xe_pcode_probe_early(xe);
> -	if (err || xe_survivability_mode_is_requested(xe)) {
> +	if (err || xe_survivability_mode_is_required(xe)) {
>   		int save_err = err;
>   
>   		/*
> diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.c b/drivers/gpu/drm/xe/xe_survivability_mode.c
> index d73cdad0b3a9..0650bbca5f5d 100644
> --- a/drivers/gpu/drm/xe/xe_survivability_mode.c
> +++ b/drivers/gpu/drm/xe/xe_survivability_mode.c
> @@ -364,11 +364,6 @@ static int enable_boot_survivability_mode(struct pci_dev *pdev)
>   	if (ret)
>   		goto failed;
>   
> -	if (check_boot_failure(xe))
> -		xe_log_err_fatal(pdev, SURVIVABILITY, 0, "Boot Mode enabled!\n");
> -	else
> -		xe_log_info(pdev, SURVIVABILITY, "Boot Mode enabled!\n");
> -
>   	return 0;
>   
>   failed:
> @@ -390,17 +385,7 @@ bool xe_survivability_mode_is_boot_enabled(struct xe_device *xe)
>   	return survivability->mode && survivability->type == XE_SURVIVABILITY_TYPE_BOOT;
>   }
>   
> -/**
> - * xe_survivability_mode_is_requested - check if it's possible to enable survivability
> - *					mode that was requested by firmware or userspace
> - * @xe: xe device instance
> - *
> - * This function reads configfs and  boot status from Pcode.
> - *
> - * Return: true if platform support is available and boot status indicates
> - * failure or if survivability mode is requested, false otherwise.
> - */
> -bool xe_survivability_mode_is_requested(struct xe_device *xe)
> +static bool survivability_mode_required(struct xe_device *xe, bool log_on_action)
>   {
>   	struct xe_survivability *survivability = &xe->survivability;
>   	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
> @@ -413,13 +398,36 @@ bool xe_survivability_mode_is_requested(struct xe_device *xe)
>   
>   	survivability_mode = xe_configfs_get_survivability_mode(pdev);
>   	/* Enable survivability mode if set via configfs */
> -	if (survivability_mode)
> +	if (survivability_mode) {
> +		if (log_on_action)

Do we need this parameter? Logging would be helpful anyway.
We should rename the existing function as required instead of adding 
another function
if param is removed.

Thanks
Riana

> +			xe_log_info(xe, SURVIVABILITY, "Boot mode requested.\n");
>   		return true;
> +	}
>   
>   	data = xe_mmio_read32(mmio, PCODE_SCRATCH(0));
>   	survivability->boot_status = REG_FIELD_GET(BOOT_STATUS, data);
>   
> -	return check_boot_failure(xe);
> +	if (check_boot_failure(xe)) {
> +		if (log_on_action)
> +			xe_log_err_fatal(pdev, SURVIVABILITY, 0, "Boot Mode required!\n");
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/**
> + * xe_survivability_mode_is_required - check if survivability mode is required based on
> + *                                     state of firmware or userspace request.
> + * @xe: xe device instance
> + *
> + * This function reads configfs and boot status from Pcode.
> + *
> + * Return: true if platform support is available and boot status indicates
> + * failure or if survivability mode is requested, false otherwise.
> + */
> +bool xe_survivability_mode_is_required(struct xe_device *xe)
> +{
> +	return survivability_mode_required(xe, true);
>   }
>   
>   /**
> @@ -468,7 +476,7 @@ int xe_survivability_mode_boot_enable(struct xe_device *xe)
>   	struct xe_survivability *survivability = &xe->survivability;
>   	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>   
> -	if (!xe_survivability_mode_is_requested(xe))
> +	if (!survivability_mode_required(xe, false))
>   		return 0;
>   
>   	populate_survivability_info(xe);
> diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.h b/drivers/gpu/drm/xe/xe_survivability_mode.h
> index cd040e4d18bb..a68f071a8055 100644
> --- a/drivers/gpu/drm/xe/xe_survivability_mode.h
> +++ b/drivers/gpu/drm/xe/xe_survivability_mode.h
> @@ -13,6 +13,6 @@ struct xe_device;
>   int xe_survivability_mode_boot_enable(struct xe_device *xe);
>   void xe_survivability_mode_runtime_enable(struct xe_device *xe);
>   bool xe_survivability_mode_is_boot_enabled(struct xe_device *xe);
> -bool xe_survivability_mode_is_requested(struct xe_device *xe);
> +bool xe_survivability_mode_is_required(struct xe_device *xe);
>   
>   #endif /* _XE_SURVIVABILITY_MODE_H_ */
>
> base-commit: 2cd78713d917a02987f21b437561a5e1e13ddda2

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D3CFB5EAF
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 05:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C3E10E33F;
	Tue, 17 Mar 2026 05:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JVriPbwr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A352510E322;
 Tue, 17 Mar 2026 05:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773724252; x=1805260252;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=OMw3U+qWkZP6QXkGMaoCCqgDTh6uCxBn4do3VFB44aQ=;
 b=JVriPbwr3/yr/e8VzQf49u3hj5c1XK7yRo6pwfgsQzLcyBSpJM9P1MWp
 Fe79WYEjk4SffJ82eD7N2K9ORqeZehjpx7+iTDRwyLH8n5682jJjhmIH7
 npozouHLHIDiOE18IG03RurMEGiHPqQUjm9dd2PI+QdBjZCsBMZ5pEYcB
 TF1Mga+yU+cs7+8A/+9bJjmas9HBNko8D4g+mIwq8ou8vGwNpr/8vUHX8
 dJCqOa+n3YdUBz6vb6iVG9uLcyZ8M8WhlJHtmStKXo8RtePR0li+uogeS
 0BOvoZADrx7Sheo0YvvOF80OO0vOL4fvF+ueJPYROmBg4cB5JQ/P3fJQt g==;
X-CSE-ConnectionGUID: 0o+4VcLTTwCaw0TfqEjszA==
X-CSE-MsgGUID: veDHav++SyO0/2aVDsmRow==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85064400"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="85064400"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 22:10:51 -0700
X-CSE-ConnectionGUID: J1f0nEhjSdObyVBLANi1eA==
X-CSE-MsgGUID: tHtd0B3KSlOIuOWUDMb+3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="226606374"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 22:10:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 22:10:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 22:10:50 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 22:10:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hk41C03BvuUkBGndu9icFUiUpEtZVmRgikAUysDaE3TGwB74Ft03l2uc6hOVBRcGY+G7vAWwsD8QzxBPWkiMc0f/O6ayiOGy+ODu2qFHiu9D5Xu0K+DcDmVey13PngrswU1mHwyBZbn3pN82SiJbU28icSe8eRMRyX79yHXG+/Uj63lCgPUWqdPUZkqjgKngd9V8a/GlDhEol84TxqT58/k8s+ZvDL+dI8/wI1rtqSxsTCezfgHNtz0O+o6TuQWN5OC5fYeuEVstK4d/LiAOKNKV9wdYhfg3Cv8gPT+uFwBDNBOl6FekGtcmTdYrDFQt+i/PR9Lj9qCKPet36YIXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QKIODD7SOnTrKoA3OQDVh/zctUEQWsXRjccTOBTs6E=;
 b=oMcCx2C033Wbfrx545n61l4VIDqdZKmy049TL1NFZ+yGM7oCzaG8zsp3gEwoWMrZNtKon9b3iQCZIDkHcxIM1KTwYdPWLBIq6UnuyaG0EeicYclRDGYXCnP/e5qHFuJe8uCRRn36KGr6BpnswRiiLChW94NjYw0aFum6eE7Bn1YeFxznLnuCfyRS1/MKLKYdIQfqVw+rLwIsmhGXEighyTYrQr35ORWf6g6wWcFLJxwd8tIgxAbjKiGVcbPTqWQP6iOP7IxZGQv51GBFHjqPxk94zvatKWZihJP4aMsVA2j/o+4yvBSuJ8QZWbqFEwtR9F7q1m4u9f8ODjxyArl+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Tue, 17 Mar
 2026 05:10:42 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 05:10:42 +0000
Date: Mon, 16 Mar 2026 22:10:37 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Boris Brezillon" <boris.brezillon@collabora.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <abjiTQe4/mRQ8wyA@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <DH44U26ZLJS2.3DTS9D6PA0IL4@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DH44U26ZLJS2.3DTS9D6PA0IL4@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|IA0PR11MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 645b699d-cfcb-4ff9-c70e-08de83e38989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: AJJi5CBPp9ylLs355qRj9UePGJY048XWJ4RyHgLL2smROf1T2OeFw0d23j9nlffMs+KHN5ZWkhMl84k5j3p+VfNOPma0qSkLOiuz8oTuJhwc2J3k7m896SG6Fbpn+mFAUch6ujMFPSzJ/3oj4Fweq8+RcUrqHyBTcLQ3Bma6w0HcgZnnvd0xnIkhOjEbp5MJF9batCVVpa5PiIw0da6gvwxbJxGJtVlWLUTQI36kkTjl61s74FRmVMR0Fyi0FiFxP9zsBusul+X07W207cJkTnelltuXU3kAncmEK2QDHvO9DVT2rIh9Jgpj5rJgmJzHBgfR0//MGw+d3xSt5yd1TASGYl+JPc70GgAkL1RI/VMhKVdh9mw5s3rRZwSw8gWhFd190S34rJ5WDWJt/SvdgUf5TYLLP6h07zvhIQSchX5+LumLQLmHlvv1UpKLP9cSFECFIbQroPO/VXzGyN9sBmTu/ibjtnbM/dI0qd2X2Hxcq/T2rXi8vAfkDPNH3fNz7go3amgJ0HMX63GUXU2EA7fns3sqXgWwERkIkpDIa2JjNA6M83F/Df7RXKMwFVHFeTf3nqexprt666QM+qMbTwc4SlW1jBuczW1cFfJQ0cGqb70btS0RWjrTxkoKQ84et+DFQqrpgp4jBjFsAzhnrSdVn3oBp9ltvPIaXvl3eOqUaWtzQFm/vASZ1Y8S1Ac6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndvNnQrekNUckJldy9BbCt5a2o3OW05dCtiUnFmcGJBdlllREZsSHpqWGxP?=
 =?utf-8?B?WWFKQ0k2ZHFoV2tiM1hDaUloMlNYQjM0THpiQXhFZWttd1YwdjhiRDNyeW42?=
 =?utf-8?B?RFdpdFJCZHhuZURMNUFoZ1FKdVhZZ1VMSGErUHUrT2tEbnhjWi9ZSzJRSGtY?=
 =?utf-8?B?RkNwM1lkK2RFalJVRlU2ZDM3b1F2U3ZHbDI5MHhkK2R5Q3lFclQyclhCT3BJ?=
 =?utf-8?B?cWI3a21kUmNpZFpmbC9NRDJMZE9KV05BUVN5UWFVOW9yc0tBUC9QQXNYaDlJ?=
 =?utf-8?B?ME5aMDg2bEZEMWZ6dEZYZ2pXTE9Bd3UvMGtuODhDZWRhWjlKUnJ0NXh6dVJF?=
 =?utf-8?B?NEtIRFk5ejRFZ1pMeVJsRkhSM3NOcWdSU1FKcUFCNWZsUS9JVGVvTWpmMXJx?=
 =?utf-8?B?RHQzaGtZeTU5OGQ4ci9wWk9PZHJUVUQ4U29SdXprdkovZHJUSEVLUkF0dUho?=
 =?utf-8?B?RzNIS3psRWdGKy9RN1hjNHFhMXNIZWV5NXAyUVRHa2czZEdsQVgzZjFHVE1B?=
 =?utf-8?B?NkZ0YVBxVjBsNWlWY2NRSnZ5OTZYb1RvemVVTVRxS2YvbWx5dEo2cFFSVzlD?=
 =?utf-8?B?WWpmbG9kSVVCTzMzWGlGYUtqNEpGZGJKRS9lbW1TdGxPV2Fobk96aHBtVXNI?=
 =?utf-8?B?c3dRR3VUUHhEVURyczh5YjhyK0tIZi9UQmFjNnprNmtVZ0xUaEQ1RFMzNlkv?=
 =?utf-8?B?STBXU2FodWFrRE8ySnlXTG1qM1FoUDVPb0pydTcwUHFsczl1dS9QdDBBZlVU?=
 =?utf-8?B?MTRlMlBoWnpJVlY5eTFQUGQwclBldGYvVTM0UzJVMk5Uay8xVzJtbEVvd1Ra?=
 =?utf-8?B?eWJUclFYYjc0TGtnV3M5NlA4YnMxeUdCUm44dlMyam9yZ041UEFNWHpud1Nq?=
 =?utf-8?B?bUszOEZyRFRjVEYyS2RRTUlxVGhsTStBWnN6dmpENDBJbW0wTGF5SFdPak9q?=
 =?utf-8?B?aCtKRjdtTEs1ZGI3UDBXaFJrKzFzRTgza1lRK08zN3RzTjhReGZlRk52ZUdl?=
 =?utf-8?B?dU1Ed01aeWMvTHJkRENjemtYenVNaTRPSmtxUEI0QlNVZ2VkTk5pS21QOXY0?=
 =?utf-8?B?a0EzVmFxcDRTdlB0UGJ1Z0paZnRGem1JMVpLWk9jaktwWHFEQzA0WTI2NDcv?=
 =?utf-8?B?S0wzMG02a0tRVFJYbzJsM0Z2eU4yMGw0NDVkN1F5dFBUSERndVlvWWJjTHd5?=
 =?utf-8?B?U1daZkVRSW0xYlhOV0RwaThxSlU1UXZjZUFXVGVIdE82SHIyUGVtSVUwa01z?=
 =?utf-8?B?UTMxNGl6U3JEeit2WC9DY2x4bFhTMFNlQmxVaGRET29JVWhHOGtQT0lZY0JJ?=
 =?utf-8?B?blQxRFg4Mkp5RXFGc3NiYnJZQkdOTk91R00zQ0lwOEdjQlhzb3NNZ2VmS0g4?=
 =?utf-8?B?NGRNbVVoeiswZTZQNDVmYWZZcVo5MHlGR2JwL1lyQnl5dXp6MDNPN3BXVFRt?=
 =?utf-8?B?YUFMbHJWeDJiaHRKSTltT215NWg0V2liVkhQamN0UnkySnVUSFhlWHo0VklU?=
 =?utf-8?B?LzhyZitrTlp6MnJucHpvazRPV2FwaDhqaTNvMlNyOHMya01XbGlxSVN1VDFj?=
 =?utf-8?B?Smhzb1BqVGV2Q0FmR0d3RzVBRGYwdERFNm1BYUlLQm0xMHI4Y0lVODFvMTYz?=
 =?utf-8?B?WjUvbVk3RWZQc2FLMVZKRTBVVDRYZXZyU2lvZXhWZHZQUVdxaGU1YXFaYW1M?=
 =?utf-8?B?bSs5UWliMk5LSzRjQ1VNUkhjUWNnMUUvSWdhNk1sN3M2dkVNcVlHSGRNMkJD?=
 =?utf-8?B?b1VqdjY0NFF1bzgzVmNrYUxVdmlCYTNtWW5Hc0wvRWx2T0dGYndYWUpCRjJN?=
 =?utf-8?B?Mjh5RUFYMWpnb3VtVTF4Zmh5Mld5ckJWOWhCTVZ0SE1acTE5a0tDZEJZYzc0?=
 =?utf-8?B?UFZ5TXVHUEpLM1ovNWtML0lVbU1BckVEUlhmb3ZnMVFVYUljL2JJTUZPOVBz?=
 =?utf-8?B?bUtzVW5UQXN6b01xRTJlNFk5RXNxSFBZQzhBRSt0TFNoa0FnWTRiMTkrODFX?=
 =?utf-8?B?YUtqSS9VSlZmN0tvQ2xsaGpWRzNTNkF0VWo3MFdPQldIV0RadDkyalVwOVVC?=
 =?utf-8?B?dE5hTndIek50MjBVVEd1UFMrbEtLdXBOOWt0dFRac3JQTkNCYW1yZHlabUhl?=
 =?utf-8?B?RW92S3RsNTNqYk0rV2ZzTU9WakpVSlpUdWxoQitwbTYzeSt2djd6ZkhIZStL?=
 =?utf-8?B?SEJBblZaOGRTbVdRK2RKTEtmY2pIMU9XQ0M3Qzd1alo4bU5iZ0RJRUcvOTdj?=
 =?utf-8?B?M1J4UjJkTmkxM1Y4T3FiQmYxVUlGd0huMXB1d01lRUJhVUdmSGRiOHk2c0p4?=
 =?utf-8?B?MmRaZUZaZkFTcTM1VTlJVUdmWFJUUGVsbFl6NS92U0hIbVA0ZlUwZz09?=
X-Exchange-RoutingPolicyChecked: ZonC0OKxtuYV7JqeNZebrZs0Mj9PFvtuYIb3JqeqJ+M3vR4DOw5wcmzzDGE5vv0UcEjkMxlzxE1X1D+dRE3E+PDWqeC54Br+U6fQabxkptp7ZQq4NfuKhIByrSeJf54bac2oslA3RlmbeFMFVoAN1nlslmMGUAPMILMYuFcoaQLj4F22Rm7CZEtymnRn1l44pHZCUq1VU2SuQECGN3fsy8EIm55H+rOThoLDoAc6PdnyfSEAobWHUPnrcg+nnTi0U3XpwpHSmxC9HHcQI3kYwAdvt4PB6ztTISUE9qUbKhzhcE43twPG+boB1gspG7Jw0j+ltBrDzGTleviyVMj6gg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 645b699d-cfcb-4ff9-c70e-08de83e38989
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 05:10:42.3113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gvOSlLi/rb8TyDqnUV8tGT4xqbfXbkXjJrNr7uaSuNVtaICpKVRjaOlD3J/jRCz/SledL6PvaUL7d5Ah/BtRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7840
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

On Mon, Mar 16, 2026 at 11:25:23AM +0100, Danilo Krummrich wrote:
> On Mon Mar 16, 2026 at 5:32 AM CET, Matthew Brost wrote:
> > Diverging requirements between GPU drivers using firmware scheduling
> > and those using hardware scheduling have shown that drm_gpu_scheduler is
> > no longer sufficient for firmware-scheduled GPU drivers. The technical
> > debt, lack of memory-safety guarantees, absence of clear object-lifetime
> > rules, and numerous driver-specific hacks have rendered
> > drm_gpu_scheduler unmaintainable. It is time for a fresh design for
> > firmware-scheduled GPU drivers—one that addresses all of the
> > aforementioned shortcomings.
> 
> I think we all agree on this and I also think we all agree that this should have
> been a separate component in the first place -- and just to be clear, I am
> saying this in retrospective.

Yes. Tvrtko actually suggested this years ago, and in my naïveté I
rejected it. I’m eating my hat here.

> 
> In fact, this is also the reason why I proposed building the Rust component
> differently, i.e. start with a Joqueue (or drm_dep as called in this patch) and
> expand as needed with a loosely coupled "orchestrator" for drivers with strictly
> limited software/hardware queues later.

Yes, I actually have a hardware-scheduling layer built on top of drm_dep
[1] after hacking for several hours today. It’s very unlikely to
actually work since I’m typing blind without a test platform, but it
conceptually proves that this layer separation works and is clean.

[1] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/22c8aa993b5c9e4ad0c312af2f3e032273d20966

> 
> The reason I proposed a new component for Rust, is basically what you also wrote
> in your cover letter, plus the fact that it prevents us having to build a Rust
> abstraction layer to the DRM GPU scheduler.
> 
> The latter I identified as pretty questionable as building another abstraction
> layer on top of some infrastructure is really something that you only want to do
> when it is mature enough in terms of lifetime and ownership model.
> 

I personally don’t think the language matters that much. I care about
lifetime, ownership, and teardown semantics. I believe I’ve made this
clear in C, so the Rust bindings should be trivial.

> I'm not saying it wouldn't be possible, but as mentioned in other threads, I
> don't think it is a good idea building new features on top of something that has
> known problems, even less when they are barely resolvable due to other existing
> dependencies, such as some drivers relying on implementation details
> historically, etc.
> 

It’s a new component, well thought out and without any baggage, so I
don’t understand the above statement. Invariants and annotations
everywhere (e.g., you cannot abuse this).

> My point is, the justification for a new Jobqueue component in Rust I consider
> given by the fact that it allows us to avoid building another abstraction layer
> on top of DRM sched. Additionally, DRM moves to Rust and gathering experience
> with building native Rust components seems like a good synergy in this context.
>

If I knew Rust off-hand, I would have written it in Rust :). Perhaps
this is an opportunity to learn. But I think the Rust vs. C holy war
isn’t in scope here. The real questions are what semantics we want, the
timeline, and maintainability. Certainly more people know C, and most
drivers are written in C, so having the common component in C makes more
sense at this point, in my opinion. If the objection is really about the
language, I’ll rewrite it in Rust.

> Having that said, the obvious question for me for this series is how drm_dep
> fits into the bigger picture.
> 
> I.e. what is the maintainance strategy?
>

I will commit to maintaining code I believe in, and immediately write
the bindings on top of this so they’re maintained from day one.
 
> Do we want to support three components allowing users to do the same thing? What
> happens to DRM sched for 1:1 entity / scheduler relationships?
> 
> Is it worth? Do we have enough C users to justify the maintainance of yet
> another component? (Again, DRM moves into the direction of Rust drivers, so I
> don't know how many new C drivers we will see.) I.e. having this component won't
> get us rid of the majority of DRM sched users.
> 

Actually, with [1], I’m fairly certain that pretty much every driver
could convert to this new code. Part of the problem, though, is that
when looking at this, multiple drivers clearly break dma-fencing rules,
so an annotated component like DRM dep would explode their drivers. Not
to mention the many driver-side hacks that each individual driver would
need to drop (e.g., I would not be receptive to any driver directly
touching drm_dep object structs).

> What are the expected improvements? Given the above, I'm not sure it will

Clear object model and lifetimes — therefore memory-safe. Bypass paths
for compositors, compute, and kernel page-fault handlers. No kicking a
worker just to drop a ref; asynchronous teardown (e.g., user hits Ctrl‑C
and returns). Reclaim-safe final puts of queues, and built‑in
driver-unload barriers. Maintainable, as I understand every single LOC,
with verbose documentation (generated with Copilot, but I’ve reviewed it
multiple times and it’s correct), etc.

Regardless, given all of the above, at a minimum my driver needs to move
on one way or another.

> actually decrease the maintainance burdon of DRM sched.

We can deprecate DRM sched, which is now possible as of [1]. I can
commit to compile-testing most drivers, aside from the ones with the
horrible hacks.

Matt

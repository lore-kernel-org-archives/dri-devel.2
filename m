Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4964BCA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 20:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9073510E1FF;
	Thu,  1 Oct 2026 20:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WW/aw/Dr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2B010E1FF;
 Thu,  1 Oct 2026 20:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790888264; x=1822424264;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=k7GaoYgr9L742oagm0IafUDdo0AICUpInJd3xAgVYVQ=;
 b=WW/aw/Drps3p7FBN8gbZoJPuHk6pryNam7LxQVPszDOE9rWDVwfsG7rQ
 nzGVMxrqoEONVIuTCRhO4FlHrXuoAndDg9MjTgfAmXfDpY3F4POx1mCWI
 5nzvgc+r9fjEak8wRHgP38mpry7ADGXZxjP+dm47cE2S0Ml6vs/KDpRbA
 +E/hct5NkoWuKcaTJw0pv9WnN4DTZeiMBlti6E9ybduEk1BBbhW0bNxfB
 lvWhCVweRiw/v4S6xvghUg6ZLjzGRbD3iVM7NVZcBrT3TlMcsGek2hCQf
 06P3puHL9SMLwv/NO8VNkFUMvbJe2ONMbWakeJgCS+d9SvsHi2E/jhyHT g==;
X-CSE-ConnectionGUID: NpzAxqjlSP2FAJGy2EK86w==
X-CSE-MsgGUID: C6QlzHm9QTOVzYtYFIznTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95470268"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="95470268"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 13:57:44 -0700
X-CSE-ConnectionGUID: K3Mnf8d/TROkHz4LzWfkpw==
X-CSE-MsgGUID: nDc5mKVkS+2j3tEoBUfmFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="275620864"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 13:57:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:57:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 13:57:42 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:57:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ce2xs0lZx+0c8mOJiQE76jZW8RvHeTFwYLcVisN4kbyTcS1Dr6FdtgqGKh48W94vNTbeqW4JxzjuhFAZSwOf6Lfzfrb9DOpnr5DoxwDlIk5H+EU8cS33ZU4AfgdCNeMWqKBdJ/pBLo8uc3CAo5KVd8Mc+dDoH7UhEqTYkSHpUbsgrMR/gkOxsXCerEeAEoUfkFqyjcUw9SZLNfUOfyPSCHcQ8+XudLcgtWndunlIeJfrMDCACicPU6ZdcEg2AUnyf9zVcG1Va2bRKZ2T8YETBF2qj05sYDB3yFKo+nFN7DVewdJ8ptsGDmiVP/LOZ/qJe9nxwaDjL84VpBPiDiRIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44rMyo+zk5XKIDsbAs0D6+9CcfpOsj0dnj2GHnho5XE=;
 b=qsO/b/KlSEEdSmUSP1Z6K+pkXfN4HWUtPtptPLGyS2CjUq5m9yV1ujfORmf8zhp0p45GJsiHBYW3eJMkMCBq1K05Ga4jeJZtV1Zed/7fnlnTxCN7elCFLqJ4Q5ih5hV9I/chTdjfGpC9pwYkN2dgc7YunTszwJ/gaCfPJoRIMvstX4HxhOpS22IV3Tl1t8fV+CSzqnJcNUGHYsq9Gd8N866XaAYqtWJcQO4rNTLjcVD03+CVCSOYvAXGmch6jEUpnk4ZY96RDbEzw8iVy9cV9rLgUIU+xQFrtUTXvdnmrHxYSAIFzvb9tf6O5Je2FC/sqwb2i7Kv4Je+yw+CMEAtSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS7PR11MB8783.namprd11.prod.outlook.com (2603:10b6:8:254::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 20:57:40 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 20:57:40 +0000
Date: Thu, 1 Oct 2026 13:57:37 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-xe-next
Message-ID: <ar7JQUI6b+PcQa4S@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:303:b5::22) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS7PR11MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f152556-f675-40e0-f8b2-08df1ffea147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|23010399003|56012099006|11063799006|260925021911599003|260925021311599003|6133799003|260925022911599003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: DcGVtMinR0bP8T9xZABGWpaMh76hWt+bE8Ww9Mo0gTf3rrT/xss0QPqPHaayDq1vd3YUUA2TmHA2Rj+ALgRqtJvCoTER6xGs1NtX+eJt0513DM1zxjPobBycD5WJns/FYyhf5zEfJ6hbCYsuimE/g0rtgiypt1Mvb7ymezQJx+uv6nTPtVkjb7L6bA077je1ylz31DGYja5cWgpo3f+DVawFAHJFIJGgMU27ky10aw4Y1r8Lc0dw+ETcZYGnS7GSAcenXyl5ZBQVXnTZvHr11ELXm3mVgQeLEoHY6zArjUUY8FHGcsHJ2jIC/mFqDR8HOg08eqk32PbJLafi8f+lIZG9tVrORFpV/90PW/1InHznUaSqPd1XN2xA8WdujQynGDLrPqSfsP5TqRAiXrGdpgb+9jsunswPNyYqJ3Ikv4rhocrSndhz20g22dVFzttwhJi8APcaIOBc0U81BprHZz+eaZ3JTc0n/Z6qRPq8n7gQ5/1GR4U5kqJZHHyoxcqzNrSrrvKuFBUIcR0z4bWpydwN0chJEXrmVQUh6FkJoMh7OLCuOQz2nSon906+IdhiPnGh2Jz/MstN8XlckPAkzKu0Nk6Rh8+k8jQegCe13GyzdJW40rdnLVkOsrFqKd9E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(56012099006)(11063799006)(260925021911599003)(260925021311599003)(6133799003)(260925022911599003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlNMWnlOUytTQW1jYnFRT1VsZFM4WkNMZnZkWFo2bnBkbE9DUDdPejA3Y09E?=
 =?utf-8?B?UG9ZWjF6dTBsaXRqbHpZM0h1YjRsTU56dW95UzBEOGJ2RldpQ2I1cDdVb0sz?=
 =?utf-8?B?dkIrRmRhZVgrOUFHNFNtWnJueENwU25oMHZURERIOFNYUHhXUGpYdWUxNUc1?=
 =?utf-8?B?MWMxTXVob3ZRQ3p6MEZTa2cxM1BzcWphY3JPaHhJRVYwdW42V05LMGN2U1RK?=
 =?utf-8?B?NyszOGROdjJWeXVNMERnVFM4SVBETlNQSFR1THE5L1Znckg2eUt5V2NJSXZa?=
 =?utf-8?B?RC9OY3UrK2Zsb3phZVkwZ1czQmNEa0xqQko5ditsNC8vbTdoZ05yOTg3NDBy?=
 =?utf-8?B?eTYvNEJvUStCb2hvdkdHOXlJNkxZT3VGaHVnQlR3Z0xOcm55Q0pnV0RuQjRS?=
 =?utf-8?B?Q0JHZU5NSkNwelIxTGZRZ1pBT2R3NmpTYWNqYnpQVHVWZ0oyVjB2bC9BWGJr?=
 =?utf-8?B?Mk5MOEVvTFIwYzN1dktwMVgvelpEUllXZXB1ZFRiRmYzNk1NSTFPN2k5MVg1?=
 =?utf-8?B?SzdoTkpteTkwVVdFUnNBOUg1b21LNmpEbGR5NHdvV0pXMElLZG5KKzBldUVY?=
 =?utf-8?B?Q25BeUdYZldHOFBzRjAzYktKaDJFQUplMk1teGZNZlFITDNoTnU0ODlQS1VD?=
 =?utf-8?B?K2dOTnQwUXQ3RzI5UlZPdjJOTm9MSVhzOVg4OUo0azlMOW0wbWs1NjlJSGsv?=
 =?utf-8?B?anN5RloxaGxKUzByb0Z0Z3FCOXd5ZTJGVHZpak0zd0hKK2w3Q0lyWDN6ZjA2?=
 =?utf-8?B?VDdCOE96N0RiRjZ0SUVOWVowT1FqV3hhTlpPUVRnQ05aVkVZcnpZVzFNNU01?=
 =?utf-8?B?OWdJYVNtV2FMNS9VWjRiRURJc1hGVVFXeitHek96REFhYWhZZVNwMGNpL2NC?=
 =?utf-8?B?UG1mRGZGWG1BYkJJa1ZLbXVqODVoSU1wcDdWdEVMMGpkWnFiRnFEb1cybDh5?=
 =?utf-8?B?T0wxTTN2RnFqb216eHZIS2JqQVlBYzFQS0o4aTJXRyszNWU0cUxsank0Yy9x?=
 =?utf-8?B?QlRjNTYrdzY0NEVFUXFHcEhScXhONm5qaGxwdUl2MzVXZEducTk1c21sNE51?=
 =?utf-8?B?SXptT2YrK2xkckx3a3dDOE5TeXV3WXJQR3g1Vk0vQ3hrYzhmNFBDTFozOVl5?=
 =?utf-8?B?Wno4MEZFVUdsZm0vTm53TXdmRkpmUEZCbTJJWmtkdXNHKytOanBScDBDZ3ps?=
 =?utf-8?B?clR3VFc2ckRWdDVoakF6UnhSRGFoeGVyOTNjYm9ETERRRjNncklVWEZLMVdN?=
 =?utf-8?B?NC9Kc3ZOUWpnS3JUOXBlRDRLNDBySWJJcTd6dU92Q1lTYVZhT1g3U2t6TUtr?=
 =?utf-8?B?R2tyRkV6M0FFanJtNGIvaTFoZmRmSExnQlRjb0dsTGJKa045MUFaNHNVWGpG?=
 =?utf-8?B?SHdWazJmeEJXQVg5UVZvOS9JNS9zV1VZWW8vTGNqa0s4K1gySWcyWWdtU2ZQ?=
 =?utf-8?B?Q3hTZWhhOUU3Y3YxVi82aGRRTi9IazJKejRKcyttUlBnTVA0OUFvbkkrMVFU?=
 =?utf-8?B?Zm90RVA2MmFsb1dkUmRqNHFlQXRKSzBVdFQwelpSUXV3NE5wbUw4bUpDaDNB?=
 =?utf-8?B?Q0RyK01vbEFEdlpqZVhLNldSRUJoOG02b1dXdzRoU3prcTdaZzNqVjJnblVj?=
 =?utf-8?B?N1hRbU1iRDdIQVJMb2lQNjhlZHRtbmdOY1RpZy9WSnQwT3c4NHI3UHZKUTkw?=
 =?utf-8?B?MFlhc01VeU9YYjg2QnVDejZEWkM1RTFvUWVnWVlmYUM4dnhKdVNhZ211UVZ1?=
 =?utf-8?B?c01ybk8reFNtSk1GaGJEUFlNWmUrZm92K2I0L2g3V1pFUWFTemtZMWdDU01B?=
 =?utf-8?B?WERrN1hTTmc5UUg1NjEwM0c3ck1kUEtncVVNdnI5SFRYYjRVTGt2NHRkQ2dK?=
 =?utf-8?B?OXB1WDFJQjB4VEM2VG5sd2luUlFkbXM4NzhlRDdDK3VHNHpTd2xlQVRJWW5Z?=
 =?utf-8?B?d1RCeDd1elhLZTdoenR6ZkM5eDlMcC9SOFdQaGhoSzhpQjVxNTlkZE9mVjN2?=
 =?utf-8?B?amlGMHRGaUo2Y3ZVR2NNU2RTTzliNjV2WThiSEJoRTBuRUhqbEFuaWhaQmZG?=
 =?utf-8?B?NlFwTVFqVWZ1RlJuakVFd09jWE9zQzhlZHpTdU9pYTl2d0F5ZGxDdDFXKzJv?=
 =?utf-8?B?cXl4ajFsbFdnbkxlbGVnUzREMGtQTnZwanE0b2lQYVJ4RG9FT2ROMmh1YnBG?=
 =?utf-8?B?eEF4TFl1SG52SXNMK2U4YUVWcXFPVkUvMHhCZmxPQ1ZrTUZveTZIN1FpQUtX?=
 =?utf-8?B?QVZOLzlsaXhraFFqWDFXYjc2Qmd6U1lwNm15N3BHckc2OUZja1NaUHAxL0Fv?=
 =?utf-8?B?aEZJd2R1blV1VzZDZ3JJSy9pZlk4V1lGcFJxV3UwWTY0czJJRjhhUT09?=
X-Exchange-RoutingPolicyChecked: 5EcXIBYGTN/dTJHZGJQjAQQCvqqneDKFyy555lqrjiyFx9H1KWfo8ZmFl8Db26+R3t156683hEOll35IARcqsQM03eTTorsiCfuDtgnpAYknDYEUsQa6GsIIAEAN7/f9TrEcZCoAuLXJoX+IDSy1xXILmtypJd1w4+7etHM+f7JWRh7rj5fJm1zQuTOFQKC717Y0QihXIFlgN6VwljJEKp70E6ptdDt7ytuXugVipp914FxRaGcr6v0bHILZKaqiorad+jltKPyxUoINdcvSVMQf3EbJ0LIa3VPcUa1StUg0kOiZ3o5JhpWbI26Ie7T3A2z00y0NxJGB+m22I/a9Gg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f152556-f675-40e0-f8b2-08df1ffea147
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:57:39.9626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSMpG0tLbRXQKWKC6+mxsWpA6ZI+pCwLs1vQPT90pcmJM9GWwcV6ftJztLNydMF9f70G8+ib//RF65lg1L19Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8783
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

Dave, Sima,

Here goes our last push toward 7.4. There are lots of small changes,
along with one major addition: CPU binds and ULLS on the migration
queue.

Matt

drm-xe-next-2026-10-01-1:
Cross-subsystem Changes:
- pagemap: Drop ratelimiting from dev_unhold_work debug trace (Varun)
- gpusvm/pagemap: Add support to get_pages devmem callback (Himal)

Driver Changes:
- nuke PTs only after unlinking contested VMAs (Auld)
- Limit sg segment size to PAGE_SIZE on Xen PV (Szymon)
- Move locking to xe_sriov_pf_reprovision_default (Wajdeczko)
- Add wa_14025941587 to xe2, xe3 and xe3p platforms (Tangudu)
- Keep VF LMEM BAR size low if no VFs enabled (Marcin)
- sysctrl: Allow per-command mailbox response timeout (Anoop)
- Drop old Xe GT ID macros (Roper)
- Implement Wa_22016122933 (Tales)
- TLB debug 0hang enhancements (Tales)
- Revert "drm/xe: Set mask bits for CCS_MODE register" (Roper)
- Remove unreachable madvise_funcs NULL check (Shuicheng)
- Remove no-op ternary in emit_flush_invalidate (Shuicheng)
- CPU binds + ULLS on migration queue (Brost)
- i2c: Re-apply use device_create_managed_software_node (Bartosz)
- Add a new PTL PCI ID (Atwood)
- Add support for Wa_16030224309 (Tangudu)
- cri: Expose device UID through sysfs (Badal)
- Enable GSC loading and PXP for NVL-S (Alan)
- Force non-compressible memory reads to 256B overfetches (Daniel)
- Let xe_guc_ct_send_locked() callers reserve G2H credit (Sujaritha)
- Implement print vfunc for page fault info logging (Brian)
- Do not dma_fence_put zero fences in err_out path (Jonathan)
- Add focused VM teardown and page fault tracing (Daniel)
- Fix ULLS for CRI, GT resets (Varun)
- Add LRU updates on SVM prefetch resident hits (Himal)
- Fix xe_mmio_wait32() to honor delay/sleep maximums (Alan)
- cri: Add new PCI ID (Balasubramani)
- Make driver unbind safer against module unload (Thomas)
- Do not emit Wa_16010904313 twice (Tvrtko)
- Fix race around q->guc->suspend_pending access (Jagmeet)
The following changes since commit 320662381ca243a3364663e917a7447afaf618fa:

  drm/xe: Poll GT for C6 before D3 (2026-09-18 11:52:56 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-2026-10-01-1

for you to fetch changes up to cf4171a20d13918e07ed01a1e01a6b546825c601:

  drm/xe/guc: Fix race around q->guc->suspend_pending access (2026-10-01 13:46:31 -0700)

----------------------------------------------------------------
Cross-subsystem Changes:
- pagemap: Drop ratelimiting from dev_unhold_work debug trace (Varun)
- gpusvm/pagemap: Add support to get_pages devmem callback (Himal)

Driver Changes:
- nuke PTs only after unlinking contested VMAs (Auld)
- Limit sg segment size to PAGE_SIZE on Xen PV (Szymon)
- Move locking to xe_sriov_pf_reprovision_default (Wajdeczko)
- Add wa_14025941587 to xe2, xe3 and xe3p platforms (Tangudu)
- Keep VF LMEM BAR size low if no VFs enabled (Marcin)
- sysctrl: Allow per-command mailbox response timeout (Anoop)
- Drop old Xe GT ID macros (Roper)
- Implement Wa_22016122933 (Tales)
- TLB debug 0hang enhancements (Tales)
- Revert "drm/xe: Set mask bits for CCS_MODE register" (Roper)
- Remove unreachable madvise_funcs NULL check (Shuicheng)
- Remove no-op ternary in emit_flush_invalidate (Shuicheng)
- CPU binds + ULLS on migration queue (Brost)
- i2c: Re-apply use device_create_managed_software_node (Bartosz)
- Add a new PTL PCI ID (Atwood)
- Add support for Wa_16030224309 (Tangudu)
- cri: Expose device UID through sysfs (Badal)
- Enable GSC loading and PXP for NVL-S (Alan)
- Force non-compressible memory reads to 256B overfetches (Daniel)
- Let xe_guc_ct_send_locked() callers reserve G2H credit (Sujaritha)
- Implement print vfunc for page fault info logging (Brian)
- Do not dma_fence_put zero fences in err_out path (Jonathan)
- Add focused VM teardown and page fault tracing (Daniel)
- Fix ULLS for CRI, GT resets (Varun)
- Add LRU updates on SVM prefetch resident hits (Himal)
- Fix xe_mmio_wait32() to honor delay/sleep maximums (Alan)
- cri: Add new PCI ID (Balasubramani)
- Make driver unbind safer against module unload (Thomas)
- Do not emit Wa_16010904313 twice (Tvrtko)
- Fix race around q->guc->suspend_pending access (Jagmeet)

----------------------------------------------------------------
Alan Previn (3):
      drm/xe/gsc: Define GSC for NVL-S
      drm/xe/nvl-s: Enable PXP for NVL-S
      drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums

Anoop Vijay (1):
      drm/xe/sysctrl: Allow per-command mailbox response timeout

Badal Nilawar (1):
      drm/xe/cri: Expose device UID through sysfs

Balasubramani Vivekanandan (1):
      drm/xe/cri: Add new PCI ID

Bartosz Golaszewski (1):
      drm/xe/i2c: Re-apply use device_create_managed_software_node()

Brian Nguyen (1):
      drm/xe: Implement print vfunc for page fault info logging

Daniel Charles (2):
      drm/xe/xe3p: Force non-compressible memory reads to 256B overfetches
      drm/xe: Add focused VM teardown and page fault tracing

Himal Prasad Ghimiray (4):
      drm/pagemap: Add helper to access backing devmem allocation
      drm/gpusvm: Add devmem callback to get_pages
      drm/xe: Bump prefetch BO LRU via GPUSVM devmem callback
      drm/xe: Bump prefetch BO LRU for already-valid ranges

Jagmeet Randhawa (1):
      drm/xe/guc: Fix race around q->guc->suspend_pending access

Jonathan Cavitt (1):
      drm/xe/vm: Do not dma_fence_put zero fences in err_out path

Marcin Bernatowicz (1):
      drm/xe/pf: Keep VF LMEM BAR size low if no VFs enabled

Matt Atwood (1):
      drm/xe/ptl: Add a new PTL PCI ID

Matt Roper (2):
      drm/xe: Drop old Xe GT ID macros
      Revert "drm/xe: Set mask bits for CCS_MODE register"

Matthew Auld (1):
      drm/xe/vm: nuke PTs only after unlinking contested VMAs

Matthew Brost (24):
      drm/xe: reference VM from PT BOs
      drm/xe: Drop struct xe_migrate_pt_update argument from populate/clear vfuns
      drm/xe: Add xe_migrate_update_pgtables_cpu_execute helper
      drm/xe: Decouple exec queue idle check from LRC
      drm/xe: Add job count to GuC exec queue snapshot
      drm/xe: Update xe_bo_put_deferred arguments to include writeback flag
      drm/xe: Update scheduler job layer to support PT jobs
      drm/xe: Add helpers to access PT ops
      drm/xe: Add struct xe_pt_job_ops
      drm/xe: Update GuC submission backend to run PT jobs
      drm/xe: Store level in struct xe_vm_pgtable_update
      drm/xe: Don't use migrate exec queue for page fault binds
      drm/xe: Enable CPU binds for jobs
      drm/xe: Remove unused arguments from xe_migrate_pt_update_ops
      drm/xe: Make bind queues operate cross-tile
      drm/xe: Add CPU bind layer
      drm/xe: Add device flag to enable PT mirroring across tiles
      drm/xe: Add ULLS support to LRC
      drm/xe: Add ULLS migration job support to migration layer
      drm/xe: Add ULLS migration job support to ring ops
      drm/xe: Add ULLS migration job support to GuC submission
      drm/xe: Enter ULLS for migration jobs upon page fault or SVM prefetch
      drm/xe: add migrate ULLS period configfs attribute
      drm/xe: Document ULLS for migration jobs

Michal Wajdeczko (1):
      drm/xe/pf: Move locking to xe_sriov_pf_reprovision_default

Shuicheng Lin (2):
      drm/xe/madvise: Remove unreachable madvise_funcs NULL check
      drm/xe: Remove no-op ternary in emit_flush_invalidate()

Sujaritha Sundaresan (1):
      drm/xe/guc: Let xe_guc_ct_send_locked() callers reserve G2H credit

Szymon Acedański (1):
      drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV

Tales A. Mendonça (3):
      drm/xe: Capture devcoredump on TLB invalidation timeout
      drm/xe: Log when a timed out TLB invalidation ack finally arrives
      drm/xe: Implement Wa_22016122933

Tangudu Tilak Tirumalesh (3):
      drm/xe: harden adjust_idledly() against divide-by-zero and overflow
      drm/xe: Add wa_14025941587 to xe2, xe3 and xe3p platforms
      drm/xe/xe3p_lpg: Add support for Wa_16030224309

Thomas Hellström (3):
      drm/xe: Don't unload the driver until all drm devices are freed
      drm/xe: Route deferred xe_vma/xe_vm teardown off system_dfl_wq
      drm/xe: Route execlist exec queue teardown off system_dfl_wq

Tvrtko Ursulin (1):
      drm/xe: Do not emit Wa_16010904313 twice

Varun Gupta (4):
      drm/pagemap: Drop ratelimiting from dev_unhold_work debug trace
      drm/xe: Park on the ULLS semaphore before publishing the next job's tail
      drm/xe/guc: Publish the ring tail when replaying a chained ULLS job
      drm/xe/guc: Rewind the LRC ring head when replaying a ULLS job

 .../ABI/testing/sysfs-driver-intel-xe-gpu          |  10 +
 Documentation/gpu/xe/xe_migrate.rst                |   3 +
 drivers/gpu/drm/drm_gpusvm.c                       | 105 ++-
 drivers/gpu/drm/drm_pagemap.c                      |  17 +-
 drivers/gpu/drm/xe/Makefile                        |   1 +
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h              |   1 +
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |   3 +-
 drivers/gpu/drm/xe/regs/xe_regs.h                  |   2 +
 drivers/gpu/drm/xe/xe_bo.c                         |   4 +-
 drivers/gpu/drm/xe/xe_bo.h                         |  29 +-
 drivers/gpu/drm/xe/xe_bo_types.h                   |   2 -
 drivers/gpu/drm/xe/xe_configfs.c                   |  67 ++
 drivers/gpu/drm/xe/xe_configfs.h                   |   2 +
 drivers/gpu/drm/xe/xe_cpu_bind.c                   | 296 ++++++++
 drivers/gpu/drm/xe/xe_cpu_bind.h                   | 111 +++
 drivers/gpu/drm/xe/xe_devcoredump.c                |  46 +-
 drivers/gpu/drm/xe/xe_devcoredump.h                |  15 +-
 drivers/gpu/drm/xe/xe_device.c                     |  43 ++
 drivers/gpu/drm/xe/xe_device.h                     |   2 +
 drivers/gpu/drm/xe/xe_device_sysfs.c               |  36 +
 drivers/gpu/drm/xe/xe_device_types.h               |  15 +-
 drivers/gpu/drm/xe/xe_drm_client.c                 |   2 +-
 drivers/gpu/drm/xe/xe_exec_queue.c                 | 161 ++---
 drivers/gpu/drm/xe/xe_exec_queue.h                 |  16 +-
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |  20 +-
 drivers/gpu/drm/xe/xe_execlist.c                   |   6 +-
 drivers/gpu/drm/xe/xe_gpu_scheduler_types.h        |   5 +-
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c                |   6 -
 drivers/gpu/drm/xe/xe_guc.c                        |  16 +
 drivers/gpu/drm/xe/xe_guc.h                        |   2 +
 drivers/gpu/drm/xe/xe_guc_ads.c                    |  11 +-
 drivers/gpu/drm/xe/xe_guc_ct.c                     |  23 +-
 drivers/gpu/drm/xe/xe_guc_ct.h                     |   2 +-
 drivers/gpu/drm/xe/xe_guc_engine_activity.c        |   6 +-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h       |   5 +-
 drivers/gpu/drm/xe/xe_guc_hwconfig.c               |   2 +-
 drivers/gpu/drm/xe/xe_guc_log.c                    |   7 +-
 drivers/gpu/drm/xe/xe_guc_pagefault.c              |  35 +-
 drivers/gpu/drm/xe/xe_guc_pc.c                     |   3 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 | 148 +++-
 drivers/gpu/drm/xe/xe_guc_submit_types.h           |   2 +
 drivers/gpu/drm/xe/xe_hw_engine.c                  |  96 ++-
 drivers/gpu/drm/xe/xe_i2c.c                        |  22 +-
 drivers/gpu/drm/xe/xe_i2c.h                        |   1 -
 drivers/gpu/drm/xe/xe_lrc.c                        | 111 ++-
 drivers/gpu/drm/xe/xe_lrc.h                        |   4 +
 drivers/gpu/drm/xe/xe_lrc_types.h                  |   4 +
 drivers/gpu/drm/xe/xe_migrate.c                    | 771 +++++++++-----------
 drivers/gpu/drm/xe/xe_migrate.h                    |  95 +--
 drivers/gpu/drm/xe/xe_mmio.c                       |   5 +-
 drivers/gpu/drm/xe/xe_module.c                     |  24 +-
 drivers/gpu/drm/xe/xe_pagefault.c                  |  53 +-
 drivers/gpu/drm/xe/xe_pagefault_types.h            |  10 +
 drivers/gpu/drm/xe/xe_pci.c                        |   5 +
 drivers/gpu/drm/xe/xe_pci_sriov.c                  |   3 +
 drivers/gpu/drm/xe/xe_pci_types.h                  |   4 +-
 drivers/gpu/drm/xe/xe_pt.c                         | 779 ++++++++++++---------
 drivers/gpu/drm/xe/xe_pt.h                         |  12 +-
 drivers/gpu/drm/xe/xe_pt_types.h                   |  49 +-
 drivers/gpu/drm/xe/xe_ring_ops.c                   |  86 ++-
 drivers/gpu/drm/xe/xe_ring_ops_types.h             |  24 +
 drivers/gpu/drm/xe/xe_sched_job.c                  | 101 ++-
 drivers/gpu/drm/xe/xe_sched_job.h                  |  56 ++
 drivers/gpu/drm/xe/xe_sched_job_types.h            |  49 +-
 drivers/gpu/drm/xe/xe_sriov_pf_provision.c         |   4 +-
 drivers/gpu/drm/xe/xe_svm.c                        |  68 ++
 drivers/gpu/drm/xe/xe_svm.h                        |  18 +
 drivers/gpu/drm/xe/xe_sync.c                       |  20 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c            |   7 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h      |   3 +
 drivers/gpu/drm/xe/xe_tlb_inval.c                  |  54 ++
 drivers/gpu/drm/xe/xe_tlb_inval_job.c              |  28 +-
 drivers/gpu/drm/xe/xe_tlb_inval_job.h              |   4 +-
 drivers/gpu/drm/xe/xe_tlb_inval_types.h            |  17 +
 drivers/gpu/drm/xe/xe_trace.h                      |   2 +-
 drivers/gpu/drm/xe/xe_trace_bo.h                   |  58 +-
 drivers/gpu/drm/xe/xe_tuning.c                     |   4 +
 drivers/gpu/drm/xe/xe_uc_fw.c                      |   1 +
 drivers/gpu/drm/xe/xe_vm.c                         | 293 ++++----
 drivers/gpu/drm/xe/xe_vm.h                         |   3 +
 drivers/gpu/drm/xe/xe_vm_madvise.c                 |   6 -
 drivers/gpu/drm/xe/xe_vm_types.h                   |  12 +-
 drivers/gpu/drm/xe/xe_wa_oob.rules                 |   4 +
 include/drm/drm_gpusvm.h                           |   6 +
 include/drm/drm_pagemap.h                          |   7 +
 include/drm/intel/pciids.h                         |   4 +-
 86 files changed, 2865 insertions(+), 1410 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-xe-gpu
 create mode 100644 drivers/gpu/drm/xe/xe_cpu_bind.c
 create mode 100644 drivers/gpu/drm/xe/xe_cpu_bind.h

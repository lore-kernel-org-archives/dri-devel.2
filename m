Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DB4C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E53410E49B;
	Mon,  7 Sep 2026 08:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2e1zORtj";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BE410E701
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 08:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3MZd17tXMzfn7P4SLdyntoLOizWIbSM24v6MJkBsthoPIyt4EPmEa6kKYt6QgL7opecU3l+auRcJULajwRnTafl+JXqEm2Bwh0nVqlUwwNdOHuKUWc6WmsEp83BnoIm5375NawYvuRBuIyIkSca1wdBM/+nEfPcTFx2mY/NXKXxW4lLXHyPpmsD9SDUze9Jtjm6JOdZOJpPg34nW6j8VQSsUFZ+NLxBBnzXpjyj7kLPyVtF5MLZg23bVi8S6gNPFzvWCxVFa5CM+4/7srpTESXlX7hc0tdW93YElVrqAafT60zcmqnshlMyMZehk1zlt7ZXu81N4GWB4uL7MLxvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drUN/s2lYocZdcmfAJKzb+/0zq2I6e6YSixOr/p6X5w=;
 b=mrzsXiyXp0RfwDvzVm3/4QTUy40R86eJP4cV5drt8SdYYH9SrLDoEvGozUDMEBrm0KnJjxB0BdW2dgRshUgq+dKK2pb+L3asVfncvs9oCLV30UkJ22BJxWNSHtiKj9TqfgvsJtVGqcw6CS8QjGY+kixt9p7X7w0yAGU3Moeutywm9hS5PpF5j4uD2pf+zjavTntR0JL9WWRCr3ym+UnH4VxEL3kkXq0olumvjTkXozN+jQVqR7ueEHBd9HxzRjluvG1QLX/2+g/0FQez0TZZUMQ76mE8RkKbablRkppNbOAMb8fckYxAuAoOxlqhdQMsMD+6zw0bu7BX6w/W94mP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drUN/s2lYocZdcmfAJKzb+/0zq2I6e6YSixOr/p6X5w=;
 b=2e1zORtj2PYkUn/DAxX4ZATi8hY/o0MtfqrYFXG874GEYsmxdBpyw4ikFxPzt6pLe/9XBSyP934fNTWW70jCsOXACPME+LoZM6PEGXqNMG4fa+my8ASJb9moN9AVVuljWBO4RNBiOwSolaCQnJmylvXbCp/I3ZwCNraR4MLlSQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by EA3PR12MB172729.namprd12.prod.outlook.com (2603:10b6:303:30a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 08:56:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 7 Sep 2026
 08:56:39 +0000
Message-ID: <687c2ac7-0dff-4c97-bbff-d1476eb1afda@amd.com>
Date: Mon, 7 Sep 2026 10:56:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/exec: Match the drm_exec_retry() kernel-doc to its
 parameter name
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260907011127.19653-1-kmehltretter@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260907011127.19653-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0378.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|EA3PR12MB172729:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ef9e72-6b90-4ac3-0bae-08df0cbdee35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: D/ewbEWKjFGcS6oofr5Th9dI8U8PCHVLrnQTHwTFv4eq0oUq0WyDLhc02wt5ixxLU8uL8Rb2dxJgJjl6KHUqVduWong4bVhyqdwO6iEZEyYCOf0Ogi0HmQ9kSIEl5Kv/Eur/iqAicF3swK012sWck4Wqx+5iTs+6jn9lhLffyeflt6s8/mFxsFtHU4qRsd+GselNLGXdyoy+k9mTxEUFgvGbQfZY40u+0kvlDiZ2mF8otzwU/9KUye+KEjMtPCYX3IE0yGVrz+8ltRxyuCw6Eyxy5RWGkuGcfLhlCaK7yTWdbadshUROxlWNQ6FOk9Ri94/pZ+8nhTlT9lYj09LirYzQ79Zmw+J+nr16xlFAGJLYrxZiOKZHsANBft68lp8fwH7ofy54vY7sMzkVPqYwEHYH4aJnE2W6Sg0HVlbFyOK7QuRbzYCicejlpesIx3EHRPWXwKC+HuONvXwhcc/pi5dsyXwV2d1vfLkTYLdjwBnLc8Yqg8elJ2vgH5Ov2D3v9b3xUv3FL/zkH+8o3G5sHsfcEcgWUzZjcwwES+cKG+PEf01WRzd/XQMuBAO99PMLP7PJ3zmU3v6NFOcC/1kNt+VQfu2yO9NkPWecftCBk3DsNFxkTrNmSbT/S/e1++1uqWBlzDW4AkC/+K1gtuxDesGtFDo3Ri8nxmsUNpnrpXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmFBcjJ5Zm8vNkpFcW9ZalJnZzJyR0VzeHp3U0p5eEo0OUpnYTA2cjQxQmwy?=
 =?utf-8?B?MWF2N0x4dC94UkNOTHp0UDk4enRxSzVxWXYyanN6NUF6QWl5VEJoT0p0MjJF?=
 =?utf-8?B?N0V1VVVKYmR6TjNHVWVnbVFQZS9Od3FLNXFSbysvbWlIRVhKbHRRZENBVnlk?=
 =?utf-8?B?bjlFeXZmdjNla2ZxSkRwSWdib1dqV1dPaDh2Tmcrak1BUk4vem92cmhxSmYr?=
 =?utf-8?B?U0pOVEh4c3kwMlFCT1JOdStONWlwZE5PWllHK1k5ekZPMm5LTHhKdXB1Vnoz?=
 =?utf-8?B?emZuc1BWZThENzRUMTJtMFM0RWUrQzZPOGtWM0N5NnhiTitRTDBJdUp1S1lS?=
 =?utf-8?B?aUNoczJsYUE2Y21XRVBWMmNsSTYvdStKcGo1bXd0azhOY1pFSTZjRWREaFEx?=
 =?utf-8?B?RmhlUWFHK1Zhb2svV2dVYlZNMjRQeVp5OXB6ZXRFZEtDalRuRmRrdGRiektY?=
 =?utf-8?B?dVE5bzZlblZmK240eHZSeDVXNFp0cXZzc01jVlhwS1Z5TDUwZVhWUC82ZGNI?=
 =?utf-8?B?NTVFZnMzaWFFVnNQOStSaW0yaTg1c0dmaUFLQjdOekVGZERFVXZnQ1pTNy9i?=
 =?utf-8?B?Zk0wcnA2RE93bHBLc09MZ3lnQTR3WFpnbloxU1hHQ0hHWWpTZ2FPeWYvVDhj?=
 =?utf-8?B?WEJ3SkhhWHkrSGdJeGRNejgvQzVrYUlUQk5WVTFHR0RhZWpabWpxcjR0VTZv?=
 =?utf-8?B?YW1TcWZNOVlWQnFOQXNEa1krbDlvQmszRWVPTEtMc1c1YU4rbHZUcFBMS3NL?=
 =?utf-8?B?aDNGTTdKUVR4UzZZbFdhdlp2QnBaVWIrNmpvR3RFdDRzcy9McDMrU3JjanJE?=
 =?utf-8?B?bGhNbjlEOG10dzNVcGhXNEZPVmdNUTZBdGkraEJIZmZuclcreFVtWjFISDlj?=
 =?utf-8?B?c1hxR0oxU3o5eWZVRlJ6R1RtcUMwdUNXQXRZV3p6SGk0bVB6LzExdTlqL2Qr?=
 =?utf-8?B?YkwyUUZ2Y05NWGtSZWx6cmgxRXp4Nkp6SWhRMkpvMWRFSlRKa2FlY25VeXcv?=
 =?utf-8?B?SzdoT0tNRGJhVlNmM1JDdFFDQVFRZHl4MTdQR20yQ3A1aXFqTDVGWWt5U0NC?=
 =?utf-8?B?VW00dmJGTWZGMHdKSDdRMHZLTUNIYjVLQkZBOUp4S0VYdWw4U2ttalUwRXIz?=
 =?utf-8?B?TEt2Y21kZDVSSWZLVm51MVN2czBWVWZocUFmNGxtT2ZGN0hKc1BhRDRicXF0?=
 =?utf-8?B?M28yMWpkNGNnZXpmTGxrYjdvVjEvcDZ0eVB1RVY4N2NWNEZFTENuSnBMN3JC?=
 =?utf-8?B?TysrVWNaRU85eFpWdVlzeDhzdE16OEVoMGRaVmtsd0tMeGtiaXl5cGErQnZ2?=
 =?utf-8?B?V2h4VGhNRHdTMS96Y0ZRRW9Ecnlnb2YzUC94WTlETUNyMm1VakN1dUtwUGU1?=
 =?utf-8?B?bVZjREUzME02VUFGTmdpSVkxbHVSSzNDNFFkamhZMWd4ZmRjby9OeW92QlRv?=
 =?utf-8?B?MkpudDlCejRQT2RaWmpiVld2Wm1XZldBN1RVNVVsaU5JVHJnSHduUUVHakJY?=
 =?utf-8?B?Z0FCVXRtTnBLVnVzemFhTTE3MVMrVDVraVVqbU05UzZUaDJ2OG1CWDloSVdD?=
 =?utf-8?B?WkZzZDBxQk5sVEJycDF6NUtQaEs3Ujl3VmViZ2p3OGZIWTJ1MVVuNjUzNFlB?=
 =?utf-8?B?Sm8xcUxzOXk0UCtKMHRIamJBWTF0V1cva2wvNlhJMjZILzlMaG9henJqc2RB?=
 =?utf-8?B?SVM0QzU4aVNWc0JPZnVxSkpucjhEbW1VdDMzSlZQM2gzZEczZEt3VmJyTkNL?=
 =?utf-8?B?dHcvSDQrK1d0M09TMXRxUXBLM0t4Q2FhWXpWRWpIWmJtUE9ndGZmTU9mcU1B?=
 =?utf-8?B?ZWZTUk9IaENCTlZtaVFsWHZMZjNkRFU1TWt1VURKZEJDUnZoTjVHM3U0T0tk?=
 =?utf-8?B?NVNBOERkcjZaZFZ6dXlmd2NsdURWTkhkeHVZQTlpdHBmWTBXNnhXcmcyeFJw?=
 =?utf-8?B?ZmNnamdnaFByM3c2TDU4bVJ0TEdGenRBMHlMWDhTRGUya285RTZBOXJrMHNV?=
 =?utf-8?B?d0VTS3NZWGJLNnlUYW1kWlNEYytqMWc5ZTZSRUE0UmgzNTBEVlVFNHVIbTZw?=
 =?utf-8?B?TmU1U214c0g0SXNOUnU4WENXdml3dERaTGdYZWMrVWJwRHRYeW1kQUk1MGVi?=
 =?utf-8?B?YnV2RTZWN1VrVXFSdnRyUVZaTS9YdzdkSHN1b1dVYzZYcDVFODdJa25Ub2Fi?=
 =?utf-8?B?Y3hibWZDRWhuTzlhRm9hcEZDdDVQLzcxRFkwcGhtRWdVTDNuVnJXK1I4Umpz?=
 =?utf-8?B?bUdMS2NxZVNMYzQwNzZycHpDZll4c0U1QnliWlQrUlROdjUyYzFkbjhPQzhy?=
 =?utf-8?Q?e6NufRLupyMusLxKMD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ef9e72-6b90-4ac3-0bae-08df0cbdee35
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:56:39.6872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pemzZ9ESTHVe+hpzuXnt19leVayZ5A2earMvM5YY2sjmv8iPnUAOT01uaFvMr5Lt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB172729
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

On 9/7/26 03:11, Karl Mehltretter wrote:
> Commit bba175a2d4be ("drm/exec, drm/xe: Avoid abusing the drm_exec
> retry pointer") added drm_exec_retry() as a macro whose parameter is
> _exec, with a kernel-doc that says @exec, so kernel-doc reports both an
> excess and a missing parameter on every docs build.
> 
> Say @_exec.
> 
> Fixes: bba175a2d4be ("drm/exec, drm/xe: Avoid abusing the drm_exec retry pointer")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

I would rather rename the _exec to exec for consistency with the other macros, but either way is fine with me.

Reviewed-by: Christian König <christian.koenig@amd.com>

I assume you don't have commit rights to drm-misc-next?

Regards,
Christian.

> ---
>  include/drm/drm_exec.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> index cc2937185a9f..ae1d074ade5a 100644
> --- a/include/drm/drm_exec.h
> +++ b/include/drm/drm_exec.h
> @@ -150,7 +150,7 @@ static inline bool drm_exec_is_contended(struct drm_exec *exec)
> 
>  /**
>   * drm_exec_retry() - Unconditionally restart the loop to grab all locks.
> - * @exec: drm_exec object
> + * @_exec: drm_exec object
>   *
>   * Unconditionally retry the loop to lock all objects. For consistency,
>   * the exec object needs to be newly initialized.
> --
> 2.53.0
> 


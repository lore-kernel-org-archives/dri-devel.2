Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2868FCD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E9D10F32C;
	Fri, 12 Jun 2026 07:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="He5s6m9D";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 428E410F313
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 07:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN7aKOgZ39DRLdhPVCuuk9MSauECHgQ1SH2vrSTJusG8mzdEiDKnEobUFq7+QyCaxndEk5xXLUlwQLVkSPjpQMMso3LtAEKUMyx+IgN7sxgg9FQkKUj7iuk6r268aZxMJR9Ftdvxn1sLelQ12pOCYN3wQDHmmGBQ0zQ1PmEgmILjcKjUZJAeazTOFuq2C06Cf0L+ty50wNG5Kw5So/5hqYTG5ZnIMSfd3duehK5D/ZZ7xDU3QMsk0fYMpFUdpFCTM1hYj17b5g0m5s1bhYMbRcDF1itxV4vTy9w68oQPV6v944Rr4amouYa0/r/VWy20w/sDWfdMfwoM56cWvaDK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dx8HD7L2JLsNbS0h273VycmScrmUu1bEn0+Nzoriz5w=;
 b=RRQy+WzcSgLT/csstSDYIJB//syg6ZF/iDa8Vix67/c1K+2o1Lprm+/ThOtqebzxov518n11wxK7k3xf5Pup1dSzYFKRXdCR/PKZSO/q87lAOQLgM5m3MnSS4J2T9hUtHovEVIuflF3ostNmmcwWVAo0sZD998sX4XciHKnksIoZkI2TSGR6diPFWF5hNPM4Nn1eDen2H4gsrnC5X8cHUU1L/UJlUIPZCq4p9pmtWykSp6s+UbHI7fCvy3BquClYwGXjQI0VGeqDB/HuinkXxOiekH2EUATkquAekeB5CYagIw8cGIzLFm1g7TVu273I0I9ROYPWXvhCmSBniMRzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx8HD7L2JLsNbS0h273VycmScrmUu1bEn0+Nzoriz5w=;
 b=He5s6m9DX3usLkfQUHXvvfa7V3axkXsCYKP3VddCaceOVJ5r/wmfzqtASNQl5oSSFwXnDvNp6wir7SfB1kRoTt9odcq7t06URtURI7KT6lYPN+ENkocREAIoZIT3YF/DkgFvJxBQ2flc1OhWrDnYTF443qtV/nl61sFoS1ogkfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 07:54:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 12 Jun 2026
 07:54:34 +0000
Message-ID: <5968fd48-f481-41d3-a9aa-1c6cccd2dbb6@amd.com>
Date: Fri, 12 Jun 2026 09:54:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/todo: clarify drm_syncobj error TODOs
To: michel.daenzer@mailbox.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 tvrtko.ursulin@igalia.com, dri-devel@lists.freedesktop.org
References: <20260601085132.683087-1-christian.koenig@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260601085132.683087-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: d2aa0b54-6c94-4635-45a8-08dec857d808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iENI2pU2GXHJ0gnxUGBUbr2Tok+cRLblzVvi4ZZKy2UCNLe0Dpf4l90u6YqQhOjY02v2LpAGPssNKSNrzMF9yVr5vgAkDPyAnlvdwR7gTNi/YFrBJwYA6YGEJumzbAFYodZPIWRb5E/WSwwjnhN6KFq8I1IqZB2fked2x9ZNVdVJjZwPe49STqRBKWp9SV1+rdyLUqO7F2Lb0JznlPYRrrBtNc5sdVR/H7UCTZqjlUAr2Ozcjv6VMOZ36gW8ZxGva7B5HSSJu804mvfz6Wf50Z8eHqAv8GizBg5kmqnbsszQwTpr1uNky68J5lPZySTjpHRk7lZXjt3JnCuvjKG1vF/k8dAph1gQDN292RLyJs4bxrAp3Ah4CwwfaFaqdVEQnR6Lkl3fVj/yaVtLKSG+gXjstEjY2mwO1Txqa/oMShKEN3L9UlRzpqqdnTPE+zK1BYo+aw+bkpU27xkRhSUOnA3/4dfoRrszPYTfk03gw2SEI03Q3s9pQ0LYk7kaNv7tyFDqlOLf7/c71mE4QUzDwDsY1tza/JtAY9BxqIDQB02B4nDU30R7K6ciZsggkNIQXCldGtzOGLOqKraFKNvC7FkrvvRLYu/GSCzl54jb5lSbR5kYDWA4iLjG8Fi8ARPpT9iuzZIVPpi7G9N0fT+1ez1il1Dv8AhE3kZwlB4KYM34SfaQJWGUNGRg0cRb/xeD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzVSbXA0VVZ3eVJyR1V3QTl4RUVmOHBQSW53K3VmUFVnbjlvQWQzTjNHcjdZ?=
 =?utf-8?B?L1FPY3Yva3FFZklxajZENTloT3JPQXJ6bjVEN3p3SVYvTFllajh4MXZhT1Ir?=
 =?utf-8?B?a0d3MThWQjA2UElEQUZpbS9Rb2hKd0Q4R1ZXVStRV2d4ekJKZTM3RnR0VERn?=
 =?utf-8?B?bzgyMHZtdzN5blpkY044OEREVkFqdzVtb1VQWmt1cjJ3bi8yNUkrR1RQU0pv?=
 =?utf-8?B?WGpCL1AyZlRhZE5uSHFMUUM3ejkxajZ2Y3BoOFc1ZG5oZVc3bmdTOVBSSnhG?=
 =?utf-8?B?U2g4Rld2R0pRdDJGajhUTDVvZnpFVGdSUE4xcDBwVUZxaTFWUEIwdjZodzJL?=
 =?utf-8?B?Ynp0Z21sNWhJK1E4YlVtNFdRTjl6L0xSSDJ5ZXp2VnJJWWV3QVpKMTRQbzZq?=
 =?utf-8?B?cHVYeTdjQU9KU3psSTVvMWhHVkdQU3A0L2kxZkRlMFlmaGRqcGFxd3VnN2ph?=
 =?utf-8?B?ZjcrUjYvVmRERHlEbXdHUzZZYzViRUNmVGJnbWZOejNjYXFZWFpHU05mTSt4?=
 =?utf-8?B?U2p6ZVFZTG9NQmlGZkErM2l0VWFDNkZ4a3N4RVJkSHdFNERNZmUzU3Y4WGxy?=
 =?utf-8?B?MVZqbXlRTE9zbDlnV2htVHhxQW5RR3hPSFh6TDlySnExK0QrVDlHdXNwc1Fp?=
 =?utf-8?B?eVk4YXJnSGpIV0tkY1F1Y0F5eTl2ekxYVVNtQWhTamhIelVoS3VyNTN1Ylhr?=
 =?utf-8?B?OWpKRVN1RkJBRlcrWFJUWUVraHRxcGJLYWVVa2JKNHdKbXROL08xWkpqNWE2?=
 =?utf-8?B?aUlFRHlNRFF6aEl1b0lWWFFWZHZ1ckNHUTRieEtnUjhMcEJQZUtsS1dmUnI2?=
 =?utf-8?B?cjAwZGxmK0poTUJUQ0lmRDBhMWhialByd3lxNHVHM0U2VU84THNKWWtZeXRT?=
 =?utf-8?B?Z1FDREtCMjFucXpWTG5zRnZGTkhQa09Sa1RISHVVRVQ5RmhTU1F6NG1NZ3N5?=
 =?utf-8?B?NFFNUzZkWUVRYzAvTUd4YWFGdkpPcklCZ05DRXVkTHMxSnE2a0tvWk5JSVRV?=
 =?utf-8?B?WGEveTJwOEI2b0NIQStjQTNQb05lM2grOHBHK0gyaFJvM1NoVXA1ajV6OXVZ?=
 =?utf-8?B?UXlYeTJRMHRyK1czejBvU21yMWRZTS91Q2h3Ry9QdXNKMlVqZ2t6Sy9SaHJW?=
 =?utf-8?B?TllrTnBZcTVrWjBYemIwY1QvWk8rdVJaMUUrYlljUk5DamlnRkpLbDRmOWJm?=
 =?utf-8?B?WmttNVRxZWVDQ0J5Y1g1cFhkaDY4bVp6NjFKSGw0U2RRRWMvdW5ObVE4Z2RF?=
 =?utf-8?B?Skt5ZXVURDZkeUJ3emVYQVRIVFR4Z2J2cEU5N1Y0UkdGeGh5TWN3bmpueCtW?=
 =?utf-8?B?QlB3NCtKaHplNTBBL1pvSStaVTUwbjZrZ0NDMXVFVmVWaS8vYmRoOHMwSWJ5?=
 =?utf-8?B?L2xLTWg0RmlSUXJmeEtGN2pxQTY0c2pxcTR6Y1JjcEF1Q2RSc0pEc0pTMTRG?=
 =?utf-8?B?bzlraVZ6bmlWNlhoemZqdXNpVmVER01KeFBhSmw2MTJ1ejRFQnRrdGpBd3VT?=
 =?utf-8?B?MXZZZUpjT0duakZWc3ROcWxtMkhNK25Gb0lzMWZTRUlEMkxzNU9XRk1RWHVC?=
 =?utf-8?B?NktDNFRWNzl6S0hKVFFaVmVoMTFWL1h1aldrUEhWeVlmWnZiTHliNUlqajlh?=
 =?utf-8?B?NTl0U1VPamxxbzRUZHhJazljOExRVWpFeXduc1ZmK0hOVVJCVnlpdnpXU05U?=
 =?utf-8?B?TXZKWGN3Ym1UNUx4Tml4RGRWcnEyL0M4L1IyTVliVjJGTzNnWmdDakdmMEhJ?=
 =?utf-8?B?a25YZGNTNnc3Ukk0dURtcHV4M3gvc2RaZFlBV0JiT2oydFk1NGtKTnE4d0cz?=
 =?utf-8?B?R2RyaTFQRi9GdkgweS9zcVl4M3pnY2YrU3BqK1hzbCtlQ3g3eGYrcm5RY1lT?=
 =?utf-8?B?QTlVWXlsL3UvVnpnd2xtRGRGZW1STk9XREpwQVFPT1hYV2VtN21iVEZOaGdv?=
 =?utf-8?B?d1c1QTBzSW5OcVdyZkdkbDJrQ3NVTHhmZFl3eTlPZ1pRNWFNNWlZOTV3MWsy?=
 =?utf-8?B?YnVKbG5aZnhNMTM3UHY5RmRQbXNHNjNUR0pRQ1FDdm02eVRZYlNJTVFNdG1K?=
 =?utf-8?B?dm1BSzFabFh2TWpLNjVvajZwVzh4Z2QwWUxROWkyRlc0cVl3TXNlR3c1cSs0?=
 =?utf-8?B?TnErRGl4dnYrS3BScGVyTkR0dHBSMlhXaWxFZmRFa3NzbDg1eHFLZFFFeklI?=
 =?utf-8?B?ODJaRVF0NHVCMnUzSGtORnVBaVlqcHBoN3MzU1Z0THdWWHZCbTNsTlorSS8x?=
 =?utf-8?B?MmU2Lzd5OTZ6UUUxVnpOZkk0aUFHbzg4SWx3Um5vYyt1TDR5K0ZZRWhZOTIr?=
 =?utf-8?Q?1fVM+d0Y4bpHT0mGW6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2aa0b54-6c94-4635-45a8-08dec857d808
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 07:54:34.8319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaT9olCZWqvYTyzgRNpeme27A8lCQCTZS+IYR2VoSERyYQAtY883kdOimMsW4Qdn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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

Hi Michel,

any objection to adding your name here?

If not I would rather like to push this to make sure that we don't get another eager student wanting to implement the kernel side.

Thanks,
Christian

On 6/1/26 10:51, Christian König wrote:
> Before I get another mail asking if somebody is already working on this
> clarify that the kernel parts are already implemented and we only need
> the userspace parts done.
> 
> Add Michel as additional contact since he wrote a really good summary
> how that could potentially be used by compositors.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  Documentation/gpu/todo.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index f5a6139356da..f85c4585750d 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -896,10 +896,11 @@ complection of submission.
>  One minor feature still missing is a generic DRM IOCTL to query the error
>  status of binary and timeline drm_syncobj.
>  
> -This should probably be improved by implementing the necessary kernel interface
> -and adding support for that in the userspace stack.
> +This was already improved by implementing the necessary kernel interface
> +(patches are on the dri-devel mailing list ) but adding support for that in the
> +userspace stack is still missing.
>  
> -Contact: Christian König
> +Contact: Christian König, Michel Dänzer
>  
>  Level: Starter
>  


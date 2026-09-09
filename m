Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E98C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C78C410EF74;
	Wed,  9 Sep 2026 07:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ufrvIEt4";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011020.outbound.protection.outlook.com
 [40.93.194.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C440010EF74
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 07:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjJicTrzb5BBv/mE7NtE4uLj63zVwfG/BVVq8Mafb8GDak7HXTzFz5OMIJ3bExkX9PQEuc1rvNa1+dKnXzMn+BWUBrsN+JId+IK/eWYmwWG8Yl3HoubadGIl6z3yoDCl++BARkocFmSk0FArd1vzT4vMFdT0fjjhZnmHXIEqfmv+qoEhsNWdQ9m30dl53MYgX+Xig4li8MCS561zhfUjH/aQodre56/OFzbk28QF02xBv0Ug+EaUTh4ohzyPlE6mnr7+SpRX34WKhCPmXqrHHs0mZw2Q0KipDSwAJX9oBjMalBh4mhydHZdDIClJOG400aK3z85mA2BytCSO6G8Utg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14SjdRw8rfNyqA886NN97ZJpVSaRjJDNcsqeg/W2z50=;
 b=AkZJFXZ+/UT0ZnTbPJk5U3L+7Sqr2gM21Gt9JjMZBk6NGel/1KAs7OS9ioY+cyZd1Ts5sKyfB0WsVlNBL+TRbUyVtCdyyEQosGprpOAFXW0fRC8L6An0lVLdMcGNLdak/kNJ2zZHbTQgTyqHpzuujC1Si4yjQhna46svANg8Meh7ReQyu/r/rNk+83EWcNNF0+GPIxghyvPJteADpOEsrCbXQnE8FjY7ZJ1qDqm49LrBRx2F5PdrlPtVdRbA1tBW7JIZ9fScUEL9Za52+PPTBfXnvYKB5YKQ1D2vb+/dfXUnPKurejuoUAgp5nR2lc90cOfHpPMci5oPvgToViHLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14SjdRw8rfNyqA886NN97ZJpVSaRjJDNcsqeg/W2z50=;
 b=ufrvIEt4fd4fEkT+xoSSA1bvtIqhvIxIWZfxcjUobdaCdV1uC10nGkxaStCrmmYoqksWedPKx/Kco53v0c/oTPc2NqUHE/aVbVIV0XA3BfxDausPQSHFzOio3gQPx5avPoGHnuirS7Jx6OTMCbilzw7MFy6Yl3I7BUuRRBjFy6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 07:01:05 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 07:01:05 +0000
Message-ID: <006076c6-50cc-41e0-9427-f54df628588f@amd.com>
Date: Wed, 9 Sep 2026 12:30:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: buddy: Drop the stale @p line from the
 gpu_buddy_print() kernel-doc
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Matthew Auld <matthew.auld@intel.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, dri-devel@lists.freedesktop.org
References: <20260907012125.21209-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20260907012125.21209-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::18) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cd9982-02b3-4f6c-c916-08df0e401da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sIiS/gEIOGxuv7Wjlw2K+tfH0H4yCsjU+cdVwYxryCR6/RWOgupf8dd7T0wdF0tgCAPKQwO/r/9+PbJtIX66oCGntH/0pKlqbYYB64yx7/RGzjL12BEuNuj0Ugq7FWkn1f8esfQ0S4pwmDtupf7DOYVlbFStBoP2vUWG16YIQ2fbIg2JqycivF7cdgZGh7YLN+NZXCjgjHnm/lWyIlK5cMP9LJkqkv4OK+JPwQJWIHp/36zUXPO3O6/HVstArwhIleqhJrRoIVqrRl5cXltspEngvH/me1jYxZ7uBfY078bhbCYo5sfcUunTaEvpiXAfRFqb2fTGFhwQ9JJvqlaVgzOTrybwYwAqKx+GIJ3C9mKRo9C8y7u9z3qrZ5Bg5BCZavPkgSfcysM0d+YtCqY7QGrbTwaBmJFU7xEEPIdKuybTYAIPGFgoW5y588cTtO1MJ0Sl7zURuPiMsM3S0cZmmXbouLhyb/DbMbjn73zsgPjW7iUxl1KFjgsT4+5k4JUGHo34ereT4lh5V/lJPMWxgJn0vPfP3osGarsD/65U0jw+gCI4xHLwUBQ6EB5K+fwxC8tylAdtaxHd9HmqK6XEBd7Bpcz5ejfa6M2qe5D0fZhxkypSl3aR4IWW8WwN8Ft+APnJTN9dRd4MBu5MLjGeWy6WUJZl4vlAl86u3Lc9tN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDF0Yk9jWnZ0a0JvUkFsbTlPTU1XRFZKWWh6WUtZbG44S0ZHNnMzN3FEeHVp?=
 =?utf-8?B?UXlXNGNKYXNJbWN1WXArTlhucEQ1amwyV2V1RUZhbE85TnBHWlJVMnBQMC9q?=
 =?utf-8?B?aHFydDlveGJnSFdjL3FTK0hBblZ4Q1FTU1RObkdvUkZLUGRnazQ1bDZYaTB1?=
 =?utf-8?B?Sy9WdC9aa3ZjeWdOOE9IeGhHaCtTMUhad0lEZTlaQ2RtV3R2U1B4bHVxdEZY?=
 =?utf-8?B?OEZGYzVYckgxWmtuNU14Z05nRmxsakc4VmUzUVR5Qjh4RWhGK1UrVmZqNDEx?=
 =?utf-8?B?c1ZmQ1NRMXJ6Y3B5MWVIdTloaWN4bVdLMW1GcW1tOUlFVmw1NDZUZ3hzTlNp?=
 =?utf-8?B?Z2grWFlYSHMrbUtUa0ZqUytuZk4zUDVPZ3ZYOXg2ZS9LNkh2VVZUcVZnOW1m?=
 =?utf-8?B?ZjZtUGZhYjZqcDRyMTdWYWkvWDB1dWVPMlc0Y3o3Yk5Oa1ArS3RNK2NRR3BL?=
 =?utf-8?B?dGJscWdzd0d1YjhxTi8yS3MvNHhUVCtyeUlXeFVzMjJrZHNZMXlOcVR0dHVR?=
 =?utf-8?B?SjNKSmo3V0xTczNBb1A2VjVrQ0JtWElheVNCMTJRTTNYWXJJWGc1Wkc5UTBB?=
 =?utf-8?B?cGo5RkJzbkRaQk8zUnhXZ212c2JLL3ZXRWcrUTFvKzZQeFVWZFhtazRKcnoy?=
 =?utf-8?B?VGRsVDg0YUF5dnRVL1dHVHlmOFB2bDdyeXhkdzA3NXp3dHZUUEg1Uno2TThK?=
 =?utf-8?B?UWkrcDZSRllMc0VpQmtUWjZFRFdYWlJFZXM5bVVaTVY0ZXpabnZOL2VNSmJ0?=
 =?utf-8?B?RkVOcVkwRmQ0Z1pBQUNtMDVGSDkxTzhJcjlxRUtLUlRmOThsWTFHSlR2VEJr?=
 =?utf-8?B?MFludjFEV3hmRWRLUjZ5NGFNTCt5Y3B5cWNVSlNRODBZVm5tTExWQlN1UXJC?=
 =?utf-8?B?WXZ0THRzL0xmcXYwWmRxbFAwVTZwR0lOTXNiVFA5QkxCdkpzZnBmSmhPRWZp?=
 =?utf-8?B?M0RsU081TFpXS28zRGpPUkViR1lsaitkRzJoaVZZajZPbTZlSXZIaEMvWnBV?=
 =?utf-8?B?aHpPTjYxQXVOS25sZHNPaHlSSVcwRlZPajdPUUdNZzM3Q1FqdzQxMStTVWVZ?=
 =?utf-8?B?c0I2V2krUXRSK3VheU80OCszVnVhQ3FxOWtTTThrNVNCOVhmb09uQlVTUTBG?=
 =?utf-8?B?V3dOVmpGVHBqTm1FRG9US3hUZFpVSHdObytOeCtScXRsbkpleHZrcDVsSkdB?=
 =?utf-8?B?UktFUFFaaWJmSFFaYmRNT3Q5M0lDZzRITWpPUXhOMGkxZ1NFdG1OUVpuTDdB?=
 =?utf-8?B?SmtQVG1JazV5T3hzOG91WGM3ZGxPNXQ0NGJxL25aNFlKWDduL1d0YmJnY2U3?=
 =?utf-8?B?L1YvS0FyeStVVmQvN2VPNmRUdlpEbmVSQUdrOVpJaTlUVkFsSTErcmlEanpp?=
 =?utf-8?B?S1ZnQmxYUG8zQy8wdGhPUWZvekVYOUdXbUMyaFlBSDhHRnkzcU5Sb1k3OFR3?=
 =?utf-8?B?S1pXdkEvWCtYcjlpcGMrUUJCZE11WHNrenVvWWlPNHhFODZMRUh2djZKZ2xo?=
 =?utf-8?B?b2k5MUNzN3NkSjdIUkdlM3FhL3QzTnhUaitpajEzUWUvbFlXWGZPK3liUmw4?=
 =?utf-8?B?TTc1d2ZBelJXd1dKRE5BVTJ1aE9UM0Y0S3o5RkJUbDVlQUNReWVLcDNCVjZy?=
 =?utf-8?B?dU9KQk9YZ2NKVjhxM1dVVHBsS0JoazR0R2lGYWJRM0ZuUWZkd2M2bzU4K2tI?=
 =?utf-8?B?MkJRQnhHcnZxYlpmVmxNVzZibE9XVG1KREtrdEJ5K0R2QmVrTUhnRVNIZzEy?=
 =?utf-8?B?MzNJMk8ycEUzT1RPcjdSZ1lxMUUwRUxJYWNEZ010U3pUOExGQkNvVFBzam9m?=
 =?utf-8?B?Wi9MK1hQWEdNS1NKdHJ4dGpDSHUrNHNvM3dNSnoxSmp0NWZQZUwwNU54elpK?=
 =?utf-8?B?YnRuWlI5dGZTNU4rRXArM1luQVBxbmNxRk5TVG5zK1pJUUVPY2hwNUFnSWFa?=
 =?utf-8?B?aHFvY204UnVZL2ljdUdEQ1RYK29LSFRjUm5BU0VTa3V1T1FJZEc0bEl0UStU?=
 =?utf-8?B?L1hNVW11WUNnVHRja3JFNW9FR3BTSG5BR3VINTF1bFR3MTJMb1B3a0U3bVVr?=
 =?utf-8?B?QmdxL1NsRTcxQU1oVDNrbm92dmpYcWdydWxxWHhrQXJBYXNnTnZGSWNCLy8z?=
 =?utf-8?B?QUJVVVdiWjNnTGtva0g4ZGorWHczb0EvL2R5ZmNET0M2NDMzb043M2RkdGRE?=
 =?utf-8?B?c0VWeE1wbFoySy9Md0FQbXVTUGQ5N3NiMUxra3UyNUFNc1hySGxYMnJjUElM?=
 =?utf-8?B?cEJiQmtEOFA5ZWlPREVrYmtqNEpkWWIvOFZ0QllzdVVieE1RZStVUVJWNENp?=
 =?utf-8?B?TERtT3RYTlRDb1JyWmNlSzY2TmRpMVliYm1MeWZmdmZDUkp4WDRodz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cd9982-02b3-4f6c-c916-08df0e401da6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 07:01:05.1417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ta37flt8Y9xShFt2plrdTvdQbldfCabYrqcl3Ou6jbxOKvMhopjOlh7WpshoUU9hfmoJMO9OCEtQkurOZjHUfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
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

Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

On 9/7/2026 6:51 AM, Karl Mehltretter wrote:
> gpu_buddy_print() takes only the allocator since commit ba110db8e1bc
> ("gpu: Move DRM buddy allocator one level up (part two)"), but the
> kernel-doc still describes a printer argument and kernel-doc warns about
> the excess parameter on every docs build.
>
> Drop the line.
>
> Fixes: ba110db8e1bc ("gpu: Move DRM buddy allocator one level up (part two)")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>   drivers/gpu/buddy.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index a5553fcec28c..cc993909b79e 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1591,7 +1591,6 @@ EXPORT_SYMBOL(gpu_buddy_block_print);
>    * gpu_buddy_print - print allocator state
>    *
>    * @mm: GPU buddy manager
> - * @p: GPU printer to use
>    */
>   void gpu_buddy_print(struct gpu_buddy *mm)
>   {


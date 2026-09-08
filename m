Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E005CC79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E1C210E07B;
	Tue,  8 Sep 2026 07:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zV3LFn65";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39FFC10E07B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmYyCLilKcIh6Numdb1Ybw/6boWDC5Cd4oQl8LnQH+nZOnkaPqMnOyACUncJNnS3Hks5j+64RdH4/Pm743bez0dTApHj64HUNofLGdjwN/l4G+ZAiIbIaKxsJmMCNnEcLlZR5X8J+ShT7TL6OZo+yCq3qEO9zbKBJYFNVKvEghuAfBKNAFGYX7rkN2xDV4WeDIgn8oRTmt66ckKb57Vmkci+UH9foH99VRzV4kXZcfbm1uTS+6I2D4naVO4AnVvtohQuVj+9uCbwjLK4WvuimtBQSo8PmPiKbYTL/Oca3dqRBOY2/bUt8d1S5FqVTkaawcBOizpdngYG3oMvmUoWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBN0BNt1rimzLQbh+hgpHfcTbv1ki6oowOF5UVjgk1w=;
 b=FnVwVjvYMy+8xYNxRu8FqsX2DKNEWzwrxol1CVfwPAhuH9yGdlWDyDGfCNmSThnwTOVdSRFbIFeKpXlX5L27/XtQ75bTLA5oJEIP5uc+YRPqhYmBvgApuzkDR5Ye8502HVJnw2BY9CSbMAWNhHDDpF7w4mi2Eev2fglq7NVxAecFANzFCKoKXrN8kLIw/nc2jCeLVimhQCkb3yJu/TYbwR3+AzoTu/RM99DS9IXkWxUy+LZ50NZq+F8Hw16TRyqNU8N+u/dfRIGhG4O1S9Ps7IPPeB6KtfgS0ANwg/o2tW2OUrddjXClpLsuE1SSb29JQvyTghWGkFx7n8Uvx3PcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBN0BNt1rimzLQbh+hgpHfcTbv1ki6oowOF5UVjgk1w=;
 b=zV3LFn65An2sN6U1Kag75NYUB25KPl9saTkLu32byjuKQKtkzHkNyM161sDZcKqunXbltGxYNeprNXqY4JfRQlOQ43KDGARQtmMK9JHNBc/yGPC75eaOMgUszlTIenFkoNOudFoO0bOLxS0OiTbzeR3WWzvbWMccGGU1hNvlBEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 07:16:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Tue, 8 Sep 2026
 07:16:22 +0000
Message-ID: <fc21c582-b9b2-48ad-a2c8-ba02c9860c34@amd.com>
Date: Tue, 8 Sep 2026 09:16:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/drm_exec: remove contention for num_objects is 0
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 "Gopalakrishnan, Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>
References: <20260907153810.2694832-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260907153810.2694832-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0334.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc20c9f-6070-46c6-9330-08df0d791654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Vz5oKyHjqLv8qoBLf+FILMTKVNTORTXl5mE9VqnKKsCcS6erW4m8FLESi8P/TELGj2v+dgU6L2Hr3B+XzHQn7uaoIOFW8PSOa3k0J9vI6FzLLTzKC6gBQ1htbglVP3nFiT6Wpawp4+SJDuut+JhlPH5WJ29zNBpj9Q3EEn5/qFinIyQf2vIOWMG47b+5kAxhlRtYRZ1I0WekbV8P5MlL1VNb5cBJyrOfjfsUWS6jsFNb06jctQdCKs7fUrqjFzyF3F9cyhd+k69ctG6PVUR1rB5z6PHKJc2nctUOSwo5HzYcr7cUhkkiNpeSCvwya/2fL4l4SJgVfsz72MYe1iP0a+X7drK7BIpmSb9GUEORCNy5zr5uP1cvDHfEWNbUZAbSbpxQQGahS4AEFn84P2gEFK+zUdyaouqFfTwBvxZXx7rqLPHJcLdJVwjvBTe7I1NhBmlJTkLDXKjg+kSu37qeemMg73STUh9EHSzdzPYZG1fYufooyw9RgdnsA+2OWITmLiDOTcp/b2u+b7qn6qOK7VSsv5cjkFqaFWVcxzGIo42zcvtdJRhEEdLheHV4K7iCGwlD1am5qr77I6s86T/KxeJANmU+bnVZynB5spFvHq4yuXR4vIB+ESUZydBJKIYEjRdibaGXp/DWonxhWjUwhId6zK2Lk9VKuW/Ns7+xZw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3MwNUtadmc4Mkx0SXhRaXVPTTlFRS83RHVnS0xtckQzUjFWb0R1dEdzditk?=
 =?utf-8?B?REUvdHlxa2ZCL21hTnU3RzFnNWxjR1d1dllyM1V3OHFHbTJOYkZtV3JjY3ln?=
 =?utf-8?B?OVR3Wis1SjVvdDdaR2tHTWVkNFlnenRzS0psSlhpS1Q4akJqdENEckVLOE1s?=
 =?utf-8?B?Y0IwZys0UGlTSFBnb21nZXZEM3FHODIxL2lKZ2FzL2d4TjdWK3Q4bTVuY0tK?=
 =?utf-8?B?U1gyTEY5RHVzcUwxYm8xUS9DSXF3SU9ob0NlcnNFV3RqNzRINDZXcDRRK3V2?=
 =?utf-8?B?em9kcGRwZUUybkZ2QzlKTWErWDJoWWxzbE5oYm9GMTJvQ1hrZTJQRFNnRXhB?=
 =?utf-8?B?Tk1kSTd4QzUzdXlDT3owUjlCSnVJdGVkYTcyWE02dUd4UnYzaU8rQThSN001?=
 =?utf-8?B?MUJkTlNXWjJGYWl0cm96bEVpVXoyRmxIVUFVek9vSjlEMCtjVC9sVVNwbzhl?=
 =?utf-8?B?NFRESHhzanhQVWZtekdTYXdSRzJSR01tN3dZb1hVRE9GenU4a01zSkZIU1pm?=
 =?utf-8?B?cGpvNGZtQjl1ZHhxVStmL0xGQldMcmJ5ZTlHZm1FdDVSWHlrRDRLTDI2ekpq?=
 =?utf-8?B?ZmgyTGVSaUFBTWh5dW1uZHRWeTJBSkI4cHd6b1VYenBMUHlMVU15cGovcisy?=
 =?utf-8?B?a2RpSm1TTlpUSHNXZzNrVVo2bmNwS1IvY1MxR0kwWGJlbGFEYkJOVDJPdlZs?=
 =?utf-8?B?ZnRvQXZYMTF6WHRZN2JzSGc1Z2pvWGNKaHYzTHRtK2VuOHJZc0d4MTFhN2Q4?=
 =?utf-8?B?OWhaTjhNMWttbjIzK3g0QnVLdGF4dFJEZ2MyMSsza2k0K3d6TTBpdXM1UDVi?=
 =?utf-8?B?RDZ1ek8zQWNUMno3S2Z0b0c1WlJheXlDemdyN3k0MFpzbmV2UGJzeC9vOGJk?=
 =?utf-8?B?OHdFNlNRQUtiM0dvOVcwc0lTcVFyaGF2RDlTdmRJOHR3WXpVYVNQN2tjODBt?=
 =?utf-8?B?NTI1blRuNGh2NEV2bXlSWk1kM09TTVdLOXNiaVhpN2V1NFRkY1Fzb1E4MVJH?=
 =?utf-8?B?Q3E0OEZaVzNWRk5rRWxIcUFKREU2QUJpNzhxdE8rYlB4VUZTcTJYUVlJVVA3?=
 =?utf-8?B?RmVqRWFrb0JKbmI0aWJ3cjRpYlBnMWd0WnJRVmVLN1BBVnJ2bkc0UEk5amc0?=
 =?utf-8?B?OXJNT2JvSVZ6UTZBcEUyOHIxU2NKMXRIRVVaaHdGdUhMKzJCMWtpZmI4M3BG?=
 =?utf-8?B?b3lReU42ay9FY2Y0ZDdBMkpHd0svSUo5UE5XV2YxeGloOW5rNDd5RDBXNXJa?=
 =?utf-8?B?SFFoSUdHeFJyVURoV29FdkhXY0lRdWdIbUp1bUQrei91eTZVSUJRakN1SDRS?=
 =?utf-8?B?dHR5U0c1VlMvQ1cyN1dHemI2TEM1dlI5UXlqbDI0YXNaNklNOGZreXFvblBW?=
 =?utf-8?B?QUdaM3lZeHdpOHRRZG1vMTZIY2UvT3Y4SnpUMTBjdmloVjNzRHJBeTJJb0RO?=
 =?utf-8?B?UnF5Wjh5NFJXYWdLQ2VwampXbjVNZjY4aGFNZ1B3VXBWa2w0VEdFMTZkYmtO?=
 =?utf-8?B?YXNFcERhL0Y5eTNjOTNETnZPNXB0VFlMWElWOWlYTjYyZjJKSDBkKytySzNy?=
 =?utf-8?B?dnNDVmtDQnAwbDdzdjJFbTVKTGFqY2hYallSU2V6Y3R0eUpRWUJiYkttWUYv?=
 =?utf-8?B?bC9hSG81eDhteGY2TUVIdHhKMjZTWmhOK09SaXVTR1BtZkY3VHNEdGtrcnhj?=
 =?utf-8?B?ZFhveGVzWUNWRk9tVVEwUFFURkI2NzhGd3lORlQ4SzlDaFpKVXE3citTUkdy?=
 =?utf-8?B?cnNlbnF5bzFZWk9UdFdKYzlVUEIrNFZrZVpsMUV4dXRzd3VDdWhHYXZ4T1hX?=
 =?utf-8?B?YlRHamFFZDlYcU96eEZKampkSFlHeDVYanFpQkkrMWJGejVvMWNpTkt6R2xC?=
 =?utf-8?B?WFV6RGRYZ1lsT2c0bDlONnJmRzZ1cmJIaVZnQ3AvZUJYNWQ4V0lIWGswY1Ix?=
 =?utf-8?B?WUNaYjRQam1NR3NWV25XVHZndGNsNzhRMFpZdDEwTlA1SUtmZU53UkVDRHpo?=
 =?utf-8?B?WG1xTlh4ejFtYXJnd09BR1RtVkR1alFMSDZiMm5QSWNSRTg5Z1k4MDZrR3Ez?=
 =?utf-8?B?NmphVHRJM0JONjNYNGVDcGEwcjB5QW1hci92ZjYyT203QXJLVFQ2a1ZvQkYw?=
 =?utf-8?B?NE94OEpidnpNY1V1S05CcEpoZDlZS0JvSksvZmFRbXA2cEF5TWNUQzZ2bFMx?=
 =?utf-8?B?K2FTZFE5ZDFUOHA0UFl4ZjU5RmRuU0NWSlZQZ25lL0JMWG5vdENoRnI5NDdz?=
 =?utf-8?B?ZlJQR2ZwMWRSNkhkUXU2bFdLcERSd2VpSFNTZms2Y0Z5d1p2alhLZG8xdE0v?=
 =?utf-8?Q?K6WA9H7s5ziHaPJ+81?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc20c9f-6070-46c6-9330-08df0d791654
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:16:22.8130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaHbbvnYco4aHCouuXv0W7DSsKnVVzXSsfF4Ixg4Ir8FFLLSGNSDgppUXs/W+nk6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810
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

The subject line should be something like "fix contention when num_objects is 0" to actually note that this is an important bug fix.

On 9/7/26 17:38, Sunil Khatri wrote:
> Drivers that chain multiple drm_exec_prepare_array()
> calls per drm_exec_until_all_locked() iteration could
> pass num_objects as 0 in one prepare array under
> contention could lead to infinite retry to lock loop
> check as contention is never reset in loop with 0 objects.

That needs a bit more description. I know what it is all about but somebody not familiar with the problem won't get why this can cause an endless loop.

> 
> Add an additional check during prepare when num_objects is
> zero resolved this infinite loop.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

That needs CC: stable and Fixes tag. Potentially the patch when drm_exec_prepare_array() was added.

> ---
>  drivers/gpu/drm/drm_exec.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
> index 7988f5e7d56a..cd360f0c903a 100644
> --- a/drivers/gpu/drm/drm_exec.c
> +++ b/drivers/gpu/drm/drm_exec.c
> @@ -322,6 +322,9 @@ int drm_exec_prepare_array(struct drm_exec *exec,
>  {
>  	int ret;
>  
> +	if (!num_objects)
> +		return drm_exec_lock_contended(exec);
> +

We need a comment here explaining why that is important to have.

Something like:

/**
 * Make sure to clear look contention when no objects are handled to avoid endless loop in patterns like:
 * ret = drm_exec_prepare_array(exec, objs, num_objects); with num_objects = 0
 * drm_exec_retry_on_contention(exec);
 */

Regards,
Christian.

>  	for (unsigned int i = 0; i < num_objects; ++i) {
>  		ret = drm_exec_prepare_obj(exec, objects[i], num_fences);
>  		if (unlikely(ret))


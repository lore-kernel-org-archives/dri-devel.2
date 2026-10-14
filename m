Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD833CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F5F10E1A3;
	Wed, 14 Oct 2026 12:37:23 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41EA010E1A3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 12:37:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebBm5j+8i69OgxgPS/Pgp6x0ppn9vVmNGm6Z5MjNlGMkLN2r7T57gAjofYcDSvbz9B7p5nLAJzPBiEZD9k0XpIQDrWqSRP7feeN4y3fb2hyaACCdgN+/cmo9WMSw8rnq6PKy+ZyKgFSWTXnoOfrzZLCUV95qR6eTUU6DSl9piT/KhoFZuLlNch0KOB2MJSzlzPsZD6gBsZFY+uFhIIPGHUGrKncq1xc/sM/xoCReWU0ngfRuc3sgp6/CJLdE9uzaTdXjX/E6QOtDf5qK138emg6vM0WzrgHHrJ6SYasvPEewBuASvFmuSswHM2IeolafiPBZQjPVL+cF7JzEcarv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeA4qNXckNWoMyKSJ6jNtiW2yKjvewAObfxw15glUks=;
 b=cbOdCDNeFHjrWns2WMeXoBrE3vdImR9KHdUTHaQRuM+K93s5JG6mZZWP1e428HLvYyRhwVhmN7CbLoDj1x6JPeCcyrFMd2cv5V4nR4I8Yk9x4+V4CfOXBIyYJl4kCOrDSrhPLYx31XUl0fSIKFwD1dG5fJ0XOgBfx6covEvixr7GCt7aYSjbyAg/8cvD9sopaVcssk4NLlvyuLjYAU8T7ojEwalClgA4JUkAgO/IV5jOIxAb+1X8Nrm7X63Om1hHtNQ4lOsRQplDFrvj3gtfvyOVfYMQocJqKcXDKD8WbrcQiXWFljTFxQxaS9wO9lW32yWtHue9oMsGTnEdZWEihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeA4qNXckNWoMyKSJ6jNtiW2yKjvewAObfxw15glUks=;
 b=isRy54UIqOlvEMsHNAo1a+gSHf+m5PcxzxHbFRGGZyT+BfCHLEO3s13yrX6zS66SWCQn9qNgq/4xfZxLVvzHRggZTYJ3+DrQ+qzQAlwKlztkAf+63CXMMp2h/v0AZ9CZ4FUj3coWLrggwwJUuItzN9nMazsDOImzse0Gwa0EV5o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Wed, 14 Oct
 2026 12:37:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 12:37:08 +0000
Message-ID: <8e1c50f7-8d1a-4b78-8524-2897c52ff384@amd.com>
Date: Wed, 14 Oct 2026 14:37:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-buf/test: add KUnit case for
 dma_fence_dedup_array() empty input
To: Baineng Shou <shoubaineng@gmail.com>
Cc: sumit.semwal@linaro.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <20260630060436.1527498-1-shoubaineng@gmail.com>
 <20261014024909.1769215-1-shoubaineng@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261014024909.1769215-1-shoubaineng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 7871badc-80bf-49f8-84c6-08df29efdc40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|4143699003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /VnGAc1eL5CkcpDZfQvJUYwqgGXTJ6Zzo2gHMfC86Xv2UlhaRg4VIYTq9ksZCYwQhJMT1dRy2+dncxEOkyB6YpCJZ4/Q6/k3nERoik92+gfwktZzWtzVcGmfw8ixLuuFYNoo3kxmGJyPFi06TSqiLLbwOmSw80mZbvUcIvSOwo1hh63BlKP6E8EV1G0wYglKu9zEzQZ6nXsDJpO2RfItld1kjdkDo3DobPEYpax+pkroV2+UdpBFC7jXWea9covDlw5bccvKAbtBlcS2G2QEDVdHNfEYnwXaqKjqo4VZK+CE31/axRFG6kpZscxBcag5lG3tU+yjnD+Gug+ob+Jtk4gMLQrfDGC4Zyu8LNIIp2ci2UX8KUsF5tK//Nhp30hLqhi12NbMBEb7EvO7z2B+c5bBgsJsx0AN8nqxFFaEsmvY3jM7Q886nzzRtzQeXQRlsyO/tKbTTAhHkiZcaezIKpWu9CCaMupc5rfFtSAis6St82wgWiq4lTmBvRRyOGcZ6ygOMiruWJApNAv3d2XQYaotTlJi1QekTGwV84z2UEcWqanyXjo91KdDfiG9g0JbY2v5376ea2VxKKXkv0KSTtv8bbAwKR2uMMDbpNWbqLU45q96rhQYQIUVOPM/MOeCIHxuXuqwfz+a4UfVpA1nk0aPojfvImHgRBJrNdiAc/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0JhOUt2b0I4VFU2Ti9aaTZoREpWbmkwV1UrN3FKOHJNM1FwakJSVEFUUFFs?=
 =?utf-8?B?NHZFajBYcmd0K2JUNDVZdTk0Mm5BTVpxTXA5elU5dGREdnhaSDVKcFd6Q2ph?=
 =?utf-8?B?UDFic1djNzJIajJKK2p6S0g5M3g2MFo4Qk1BbXlHRU8xZW54a3ljQ1dRRWhv?=
 =?utf-8?B?dGtHZTRxc0pzMkFNTUh6ZlV0NXhGWXh5SVJCTmFZTjFSU1ZNaERySHdCZEVp?=
 =?utf-8?B?VDNaaXRya2JIQ2p0bXNyOEgvbzd5Y2R1cGVyVnNnZEMvUjUwK2xOMTZLZmFD?=
 =?utf-8?B?MC95bUt4NmEzRzFTM0d6YnA0d0M3NE5RK0Q0VVRKaGZ1bkp3U3A0WVN3SVlJ?=
 =?utf-8?B?ZWIvdnZZdXVta0xITkxBU2d1alRYVVRuK0l5Nm1FeVdJMWxITXEzZmpVaWx5?=
 =?utf-8?B?NVAzMmtIVGNnODRORHRKTWhNd1VmZHczbGtQT1FMYnJtSXdXMjIzOEd1S21o?=
 =?utf-8?B?L3duTlllZkR0TC8zRm5YVzVJclZ0ejQ2akx5YVJRZTNnWTJ3Tm92Vzh1WEJw?=
 =?utf-8?B?RC9RM0wzYWdDNm1aQ2RUNXJRMWhmOGJMajN6bmttUVU1SmdGRnVTZ1JCb0c4?=
 =?utf-8?B?RnExcUhESjZrdFFDeXU2WVY1UTR1aDNZL0VKWGo2L1FpZktIUUtqU3hYUXhE?=
 =?utf-8?B?WW5SUE5TdTYzdmk3aVZ6RWRkaXVLcW9FZ1NwR1I3ZnYzblVJcnpQVG5OY3VR?=
 =?utf-8?B?T1R6RXZCUHJUODVWODdBKzhjZ0VlQTZqL2tvS1V6SmdaelI2RWNZVGJ1YjNn?=
 =?utf-8?B?RVhwWElJd1krNDBuNFZtSW1FV09YODBVT2orMVdLQlREWHp6dlFNVUVQRUNO?=
 =?utf-8?B?dVhJeVR6bU5YYmx5VmRVU2FTNFZlVkU4MWxhWUhzZXFVNGNsaWhRcDNPcDl4?=
 =?utf-8?B?VVg3c0VCUm9KbWxBT0Z2ZDdHcnViSnFScEFucm1hRjk2RjZjb25wUFJVTU5E?=
 =?utf-8?B?dnlka0haRFhKRGZOYjRMSG83T1pieXZ5YTV2Q3RlZVVyZHE3VWlyckxoTzkw?=
 =?utf-8?B?SVNncllFbW5oZDg1UWl1WnlmTUpUalUvWU04OTZ5cmhoSGdNM0hnTVNzTVdU?=
 =?utf-8?B?cHN1NUt5bmNnSEZ5SkhjZlFBTTMvblJDNThaSG5LMWxXTmhERitLZWlVdFZk?=
 =?utf-8?B?OHA0NHFzalhVUFEvazJBK2lEYlNNWUJRUnJ5cmJGMjlabk1KMGhwYUhILzdo?=
 =?utf-8?B?OXFyUDVDV0RQUmZhL3A1MTREdDVBbUYxejdJTnZiRlpBVUg4OVFnbTkrVjRZ?=
 =?utf-8?B?MHROa3BpR1hzZnhVa3BwZmU0M3B0eGNZTlRVcVZVNGFlMUptN2Jtdnl4TlFl?=
 =?utf-8?B?QTJWZHVQOS9mT0orczlPS0FXWVN1SnBXZ0lBUmNWSFU3RmlCQk9GTW5IdHkr?=
 =?utf-8?B?NTVEZFNTQnQ5Yzd5d1gxaGNnTFY2OUFod0V4YUhXSE91anltWEp3SU9MdWVm?=
 =?utf-8?B?eHROREtjTlE1c2FvRVY1RHlrVGdvRjdpaFUwYkVYR3hZN2JYZzBjaS9tK00y?=
 =?utf-8?B?Y3ROZ25IMHFGOEFsVmZrbFRYQktPbVpkR2htUXl1MnYwdUg2UmFZdXZtdEZw?=
 =?utf-8?B?M2FwYmNMZjRWR09FeHp6bmZOZTNoU210cXRHbWFVa1QxQm1nVDk4ZGFXdllH?=
 =?utf-8?B?RmcrT2QrL3VRS05Gb05BOFl5RFErWTZWSUFtOGEwUGU5a3VBR2Z1QTRKZnV1?=
 =?utf-8?B?WGd2K1FLME5GOWVkN3ZXREhjL3ZwUEkwczNvcWxDTEd4SHN4b3NkQmVsN0lY?=
 =?utf-8?B?TFFSWG9ZZ3BzbTBSU3NwdUJtNVRIT3l6eFN5NlcwaGJobHdncEdYVG9qYmFp?=
 =?utf-8?B?OHRwVWNjeGRXQnVjU09MZC8wdVpHcVBJMld4ZUo3N3pTV3JXSnB6TGFQNFY3?=
 =?utf-8?B?Z2lYd2FhbzFoRUo5bWJjcEFRS0hWT20zYTV2NzZyTUQ0WDlPTDd5dWtYazBY?=
 =?utf-8?B?ZmNwdFZvVlhVNHgwS1I3S2ZTeTRyaE1nbE1aMUF3cVhmMmhtQURlWThTNjJl?=
 =?utf-8?B?N0NTWkEvVDJSUXdlVGFBdVpXZThyaVFzaG9IMVdzRlp0OWtnSGVNRmtqbW1P?=
 =?utf-8?B?dksrSHlMVGNkT1ZkWk9KMFlDNlpUL0FxZmJyMUpvTFVGUUFIV25lRzNPa0VH?=
 =?utf-8?B?Wk5vYXp6NmovNTBYcVk0clpBVWxNcUM4UHdpQTlpTFNkT0o4cVZ5TmVoOHpq?=
 =?utf-8?B?ZUd2c2hWYm9XYkZSVi9EcS9NMGQyQ1BGSGkxWEFBMWdtOHpuU0NDSkhhVGN0?=
 =?utf-8?B?NU5VVzdlU29lOVF5UE1kcmMrYXRVTWFuYXd0bnQwUDA2RThTOU5sTTVsM3Nt?=
 =?utf-8?Q?3VJQ84dYLDhvsX6PAI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7871badc-80bf-49f8-84c6-08df29efdc40
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:37:08.0677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqD6XWK9Yq7lMsjlrqYI1rqWvOXxBPYBxhykwr16nrrKfgXY4nMvJZnJah0LNboF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868
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

On 10/14/26 04:49, Baineng Shou wrote:
> Add a KUnit case verifying that dma_fence_dedup_array() returns 0,
> not 1, when called with num_fences == 0. This locks down the
> contract documented in the kernel-doc and prevents a regression
> of commit 77a9298741f8 ("dma-fence: Make dma_fence_dedup_array()
> robust against 0-count input").
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>

Thanks for the reminder, I had to wait for the -fixes backmerge to push this.

I've just pushed the patch to drm-misc-next.

Regards,
Christian.

> ---
> 
> Changes in v2:
> - Add Reviewed-by from Christian.
> - Rebase onto v7.3-rc7.
> 
>  drivers/dma-buf/st-dma-fence-unwrap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-dma-fence-unwrap.c
> index 4d9d313b460c..c5353b36f0e4 100644
> --- a/drivers/dma-buf/st-dma-fence-unwrap.c
> +++ b/drivers/dma-buf/st-dma-fence-unwrap.c
> @@ -370,6 +370,15 @@ static void test_unwrap_merge_seqno(struct kunit *test)
>  	dma_fence_put(f1);
>  }
>  
> +static void test_dedup_empty(struct kunit *test)
> +{
> +	struct dma_fence *fence[1] = { NULL };
> +	int ret;
> +
> +	ret = dma_fence_dedup_array(fence, 0);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
>  static void test_unwrap_merge_order(struct kunit *test)
>  {
>  	struct dma_fence *fence, *f1, *f2, *a1, *a2, *c1, *c2;
> @@ -595,6 +604,7 @@ static struct kunit_case dma_fence_unwrap_cases[] = {
>  	KUNIT_CASE(test_unwrap_merge_order),
>  	KUNIT_CASE(test_unwrap_merge_complex),
>  	KUNIT_CASE(test_unwrap_merge_complex_seqno),
> +	KUNIT_CASE(test_dedup_empty),
>  	{}
>  };
>  


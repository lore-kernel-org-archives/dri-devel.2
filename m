Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41189EC01B6
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A304B10E2D2;
	Mon, 23 Mar 2026 09:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H6YSAUX8";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010036.outbound.protection.outlook.com
 [40.93.198.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D34A10E2D2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 09:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFS5GpPCRQvahphdly96G7OHw8Kln94eix3ccgXeXaZbqPoVKC3YseJntAcoQdRwLTL+nd+6FZO0dYVEg/mpfCUTaaG3M5kVs3JynLee+f5qi8bkxMVtXBZ3zWuurJSNQGzoGU1p9gUhqCHTwv7t9/f5Cn4NKx2Afs7hXZaK70+fIAX1XHFmW1HN4riK0YuBF8eX3B7WVOfYkzKy0IT3R6C4JZ7kvnNeFC/2Q5Mby/e3gqO84IEVORjE8JmXDcpZQ04u9qXIvVKDdsioUTHhB5CYxxfOXnbdtrc2ygfg2ZaNulW9p1GrFNWiSTlYO2vg/GVZAaikc89JB0bhU/zrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaLzvBXhCSwiB+/lMYhDOAwgwR0vVj8xqaBoJHIQBFk=;
 b=nTEyrThj2pBV2VsZOc6q3qGhQoUQfAnon3nA0+JUf3YpS3qBOS+vPSAbIpssXkyNkhU0/pbOyWRlzR4/+0OseUN+5hnNNilluWZmhpeFO9OKBpFWk8CdSF8rRIlY5niZv7XLtJrYbL8OeIbak57+v4YEFyC784Slea38r1AIChacg1KcW1IWkSrDD+f/rReEgdM4IfeuVLWMaWWuD4X5/0njH/TNoPhcTU9nBbZkyTIYqqlShtAsX+0HfQgekaDS8Gc/Jo2pqQ7kH4f0XhG+EOwaT4Ch9f1ZtfBXWfHOd2sg4psL9tfbiD7Ggcf0Z2RHQLaNV82uCXfOuibvcX3UvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaLzvBXhCSwiB+/lMYhDOAwgwR0vVj8xqaBoJHIQBFk=;
 b=H6YSAUX8HVBKHYuPPiTWK9ToyOLeRA5GoWZ4UAzREPZCaI5DWKQUPn9PHQOLBULn44zqp7AuCKWbVX7QEPnNLFMZ/Ia5LsuU1Ve7DTAIeLs0BaZHjfgXBnsZ9Kmsq7WIKmdGfAbDBy1amS4mFwmM8aANTZx77nHRr6l6ZONdhNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 09:43:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 09:43:59 +0000
Message-ID: <08eaba8c-ee4c-4c9c-a4f1-781949919cd8@amd.com>
Date: Mon, 23 Mar 2026 10:43:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: fix dead default for DRM_TTM_KUNIT_TEST
To: Julian Braha <julianbraha@gmail.com>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 karolina.stolarek@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260322220125.1380776-1-julianbraha@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260322220125.1380776-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: b89316b3-a652-467b-17cc-08de88c0b520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: B3aqTvV3OHBfjwFQGC9AI+RE/FaK5upWajONEzXoT730+gS6WO5S6dzD/m+mVTwMhog18aGDZu0QPVSDu+jdOL21Px5ieSS+oP0weZz5jkAexzAS9iiAl7XI0emw6vBugZUV3DuAHW4LjwqF/lHaft52O3QOiQsnHgvMQNXtnJDzG6EEyAJfSFapPgX9VRSSyuCFCFO/yJfDYZu2WoX3YyF26XuVrujJMlUs0IH0Mz0oPTnJH28109mQOiSbDM29mKKfL3lQTV7+uZaXWX2TnXIev/bbFzEqkH4PuN5xR2dw/gKocyIDMMZJ4A+qmZCDS1jb9x0jLyPDtUIsf0cLB8iC9NeOnF9uBaSm4fEgdFtF1PH2T0p8hV6Jilsni2UoEi2CFdbh9e3qs+bE+ykDJR7mg1U2u0qu3Nfvl5XjNClZm7PpzO/cW86DoSZhrbsLsaEhZGiwl6SBWoG9hjEQBEEfqHhc+LQLYYke1vp/VY3B4qo5ZGBRf8RWKSbXBQ0PgdO8I57oY3dKN6LGHdAy/XympWU5JwQwfHWhL6nS257MelsuDB6OG8HW5FCQWZTtUslqPyMaTVw4Z/xBjmjY/9ua/Xo1FMWMjl24T0hKaJSsF4tD16lAXRoANDykHAliKhThZ9ihdIfnojOYyAMuEClSEmUSj+gS3DnlOtATK2SsubCG80nbn2gCErrQW7OqbQRxLqfReihEvvKda0nxXw2YbRoXSEdMEXxCvih0X/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnpDY1UxbVp1TDJkLy81a2orQXQ1UEVjY0dGT1Bra2hPTExseUNJUkpYSkhy?=
 =?utf-8?B?N2VpODdHVEVWSVVoRFVNU1hDbm5udVBmOVpIVmFwZkJKOFAxTWRYOEJKTnhV?=
 =?utf-8?B?TEhaM0I4ang4OTJMdjNuWDhjb3Q2anJkemM4b2lNZDBpZDdSMVh1aFVEZ3BG?=
 =?utf-8?B?TzRoeWw1WDFRNDZ4WGc3MFZMamdYOVk4NTY2c2dSOXVRUDFETXdsZ0FVN0Ez?=
 =?utf-8?B?eW1BTC9adUJJMjJOZ1paMG5NalFKVmQxenBWck82UnNuemlzbGl5VUloZXhU?=
 =?utf-8?B?Qm1DODlzY1R0UThqY1JQcFhrbU9CMnh0NCs4QVRwanFiYlFmT0JOWGZySktH?=
 =?utf-8?B?MHkxV2F2U0dhUmdxcmpaZjlNTE52MnVYZzA5RWI0OWVoSmYrazlyZmt0RXFi?=
 =?utf-8?B?Rlo5YXZiUHdiRXZ0OGJsdEJUMTZaVStvTnc1aHhydVhWQk9HYU9INnpEUTJ2?=
 =?utf-8?B?Yk9SRVZROStHK2twMk03TEtqcVFsM2p5RWkyeW52aUlKMlZUQTlzbkI0bmI3?=
 =?utf-8?B?WGhubVhydjArT1F2a2xRNTBUVTNId3YrTDAvTGlVVlpKZTF0K05EWFJCOUgz?=
 =?utf-8?B?SDRDM3hvS0luV1VrWkIzMGJHd3BKVnA2OWxlY3hyU1hXcWVtQWlDdm1EbWdJ?=
 =?utf-8?B?clZkTVEzSlhQZFFucmhKNkxPMGczZmtGZHorSHJzY3VhaWp5eTcwOGdkZGti?=
 =?utf-8?B?RUdaM1lRSUpsd2Y4Y1lsNE1mMGxEZGVKdWJKQXZxaEN3ekNtdmU2N0RRMWNQ?=
 =?utf-8?B?TS9jL0k1WjQ0RGlDcU14ODZQemU3cWxUa3RxdDdQUXh0cWluRkJJaGxJMW9x?=
 =?utf-8?B?WWZZeW1PTGNmd2JwQWNTRjVTYVdrYUp5eWhDTENlSElYL3VyUHZtaFk4Y2VV?=
 =?utf-8?B?Nm5kOFloWjJUOEdDeVc4TDlEWnYwaXJ4SjB6ZlNmS1BLNFFPd1kvVUJmSTJN?=
 =?utf-8?B?SmcrVXNyeGVZSUU4VU9CN3RQRllUVENTV01BSTJHU0ZsS3FLWDVNQUUrSmdI?=
 =?utf-8?B?WFFCKzhmWFFHSnEvM2FFRERlUVA4aitqWEhGNFF5NVl0QnhtZ013a3ZJVDc5?=
 =?utf-8?B?VTVSQ25EeWNMWmp6RmJUc3RpWDM5NnROWmxrclI0NjJ2T2pZZGJoaXlYelJN?=
 =?utf-8?B?SkUxdXJUZmZKRkQ2NktGMDY5MGNmQTVvSVg2ek1USncwNTdxa1hqVlVCMksz?=
 =?utf-8?B?WHlJVlZyMmFtV3QxZ3lXT0QzejVEVkpZWGtkaThWOFFyblY4M042eUYxTWdI?=
 =?utf-8?B?MEdTTzlVUmVPcSt5VEJpVkpKdXYzN2J2WjNFbEl5b1pqbU8rTFc0c09tVFY2?=
 =?utf-8?B?K3ZzcnRBZ1JPVVBIZzI0emV1SkZJbkhTTGRuOTZ4RGtXVjhSSXhHZHRiOUxH?=
 =?utf-8?B?SzdKNlV0WFE2RmhsdG5zSzliZ1B4djZyZ3JrY1l4WlZ5VmVIdFMxcEFsb2NC?=
 =?utf-8?B?Y2JQL2VzdWg1MGhSNFJ5eTVjcGxIc2JhV3MwcGo0aW1hTU16c213OE9XRmJ4?=
 =?utf-8?B?ZWMwS0V4R2hPUWkrTmJIeWFXUjR0TllwbTkreDU1M3VGcE1Bd0JqWWNTQ0Vn?=
 =?utf-8?B?eUhFR1FsdUNjTVBHNDFoejN0b0tzdDl3a2JYa3c2YmJtZkJJa3hmUnAzQkx5?=
 =?utf-8?B?TlBBUkJoVzZLU3JFaTJZZWhpOGowcUQzbmFIcTJnSm52WVNaWWoyNmxLZ29q?=
 =?utf-8?B?cHZGcXVDbGVKTnJSdWJpaGwxb2NXT3ZMVWxRa3djcEtMTTlqNjFWVkQrZyta?=
 =?utf-8?B?YWNlcjhSb1ltSE41N0UrL0dkQlFtYzJqTk5FaGJabFpwWE9xVFpiM1VUc0Vn?=
 =?utf-8?B?eE5TYnp3eWdaQkNZT2ZXYnlNQVc5VGx2djNFYjhIdGRtY2FvbFIwL1B2OHlP?=
 =?utf-8?B?UEtJaVBYYk5Za09pN2lBSk5yb2pVb0ZpWUxzK2xlNDNrbmpiUUgzRlhway90?=
 =?utf-8?B?RHVSdVBHM0xnS2lqN05KYWFheVVpRTY2UDZTeFQyb0Q4SStrK1Z1WS80eW1h?=
 =?utf-8?B?bjNmU2ZUejNkOWVJMEVTaVcyQS9oVml6T0JoOTRXNlZ3Vmo2WXJZVWVJTnFK?=
 =?utf-8?B?NG95YmVEb3o5cU8wa0FVQnhxcGJ5c09BOHFGdm15eGZGV1dmT09hb0pQWVFh?=
 =?utf-8?B?VDZDYUE4S3I4c0pBVUZEcldvZ3FIeEZjekFUQjBUQVdHRjRjak9idDIxMkFE?=
 =?utf-8?B?VmxkM1RiVlA4MWJqaUIvM3FkZFdoc1E0bE1JWmNTbWdpUXNod1ZXVld0Z25Z?=
 =?utf-8?B?UXpTNkFXSU5weGJHenVNTnhrODZuYUNDUUhyQ09RcTlKeGVRNWU0c2RYcWpz?=
 =?utf-8?Q?CJDnZLYYeyZqn8SsSH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89316b3-a652-467b-17cc-08de88c0b520
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:43:58.9876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTBh1+UOGLQwKQ8ai+cDWN4yZ5BhN5W2NnhTWorUCszk0nKwA/TbhZG48NFitozc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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

Hi Julian,

On 3/22/26 23:01, Julian Braha wrote:
> The DRM_TTM_KUNIT_TEST config option should default
> to KUNIT_ALL_TESTS so that if all tests are enabled then
> it is included, but currently the 'default KUNIT_ALL_TESTS'
> statement is shadowed by an unconditional 'default n',
> meaning that this second default statement is currently dead code.

I need to double check the discussion back then, but I think the tests were pretty beta when initially merged.

So it was intentionally to not include them automatically when KUNIT_ALL_TESTS is enabled.

We can probably do that since the tests are stable now, but I think we should definitely drop the Fixes tag.

Regards,
Christian.

> 
> This dead code was found by kconfirm, a static analysis
> tool for Kconfig.
> 
> Fixes: e3912d09bf8d ("drm/ttm: Introduce KUnit test")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  drivers/gpu/drm/Kconfig.debug | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
> index 05dc43c0b8c5..75c186f938b0 100644
> --- a/drivers/gpu/drm/Kconfig.debug
> +++ b/drivers/gpu/drm/Kconfig.debug
> @@ -86,7 +86,6 @@ config DRM_KUNIT_TEST
> 
>  config DRM_TTM_KUNIT_TEST
>         tristate "KUnit tests for TTM" if !KUNIT_ALL_TESTS
> -       default n
>         depends on DRM && KUNIT && MMU && (UML || COMPILE_TEST)
>         select DRM_TTM
>         select DRM_BUDDY
> --
> 2.51.2
> 


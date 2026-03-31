Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F5E10F9303
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 20:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B80D10EB7D;
	Tue, 31 Mar 2026 20:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cvGUslmc";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2AF10EB7D
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 20:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6aCCJeCZ65NfEX0fQ3bH7T6tyQcQmrs8nA6Zwg5MdeHCWctCiBi5dJLeN2qExCiktteKKw3eckgpVgXXsauI7K5wuWAlhGTMiQkZ+5lqFmkY4MKo3b07mbDDfYWyPZHS8mjo2BU7iMMH428tTAZI74ew3b/1kkvd6vb0PlzmAJHulS2GH1FXdxqDjK9WzSzQzBEDhVpiHnpvJIwTz5r53syp4DFN43xvTcdfqD51SL+bFJ0Y1NS2Da3cqM7r3kBy7Yguh27hU3IgKbnCWqtkLDE60fUnlhhRh4YRjxsBlrIihgQLx7NbwH88RH6D5Ln33aowCkZVTyd/ZA+maVPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pofa1tKGm5H3S5ha3BpuYF4ZN8JMyfi9zcMnetl3htM=;
 b=a4MCbwKugPMGYlRu+yCfV/C0keGYFF0hJNilm3cUvU+Q3hHVilaAQ21UNwEeU04Bz7Db54AnN4X6s7SZaOO+JLG3++3EBfHUFxDs6hrm6iLxna4UvF38i656jrQ6Nj8iEuAoFXGwbm1x+EiEmESXvPBveeB7IJj1tCLaJmsViCexXrUuOQohAd+85jEBpRQij5dxuchCe9k0RNZMZUKu7uI+IiVBmDky29+z5nSON8FXT4D1wS0pQY3NRu9umGm111pVUEaSZnnrRRN2cb/nD6uDNl8lDGSUeTGIjwQXDqOmHsTvNWHY7IMT2QineDXnjgmX9Di1BkEs/p/Gkd+AAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pofa1tKGm5H3S5ha3BpuYF4ZN8JMyfi9zcMnetl3htM=;
 b=cvGUslmcmdBiVre8wb4nvA8Zw1ZFHtCNTAm6H2IFWIzaTgllV9h/lJZvw8rb+m+NkxAcko7gLjNPrceFILXrDXhuUgLKxlHP4KvgPH/wAU/eNXCPYj1uY6zNjDBF/ItLUT8UPKjEkfs+1wgEGOCZ/vNXkeguJwLMtf90OuTODMqrfYhY3HY+7+963DR4acg6XnUMab9XRj11e1jfI0I8zVBMOw/CqgbB9f/R7Q70F3V8IKPJ+haU6r8xJDwsWGAQvgU3Z4zasWROvDG20Ed2the5VN/zqZhjrhU2OnonLAs2XU45IXHUDQnGbIIPPhyLRXQHsJEaN3Ueg7GkOd8Oww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 20:53:51 +0000
Received: from LV3PR12MB9412.namprd12.prod.outlook.com
 ([fe80::c319:33b5:293:6ec4]) by LV3PR12MB9412.namprd12.prod.outlook.com
 ([fe80::c319:33b5:293:6ec4%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 20:53:51 +0000
Message-ID: <a97a97fc-ef55-4eac-ac9b-dcd8c7903c66@nvidia.com>
Date: Tue, 31 Mar 2026 13:53:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: bitfield: fix broken Default
 implementation
To: Danilo Krummrich <dakr@kernel.org>, Eliot Courtney <ecourtney@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl
 <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260331-fix-bitfield-v1-1-ebe1a72b4fae@nvidia.com>
 <adae6d13-e70b-4377-a9fd-4bfc985e3d89@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <adae6d13-e70b-4377-a9fd-4bfc985e3d89@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0072.namprd17.prod.outlook.com
 (2603:10b6:a03:167::49) To LV3PR12MB9412.namprd12.prod.outlook.com
 (2603:10b6:408:211::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9412:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 43463c31-9e6d-48da-a84c-08de8f679ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Mpnjt6eaC79kIRtbXCTI+TZNcwLM9ycKIvaR+aXmy9pXnLXNrSc960BNo36IBzajW0ooHUQOhxhUnyR3DnwqccP3VdjlH2tmCimgeskri5CytfqBVN1shvZmq+pxc92ncsYP72tz949hUfhCF88IT+H7tngoQodTRIocZw1LZJvh6WIdlXprwdgqpF172yd7/UY+BjKx0gPaFqMhoJ48LOhCzqvd3hzIItEXj0XJ3qXPKTsNYHbvvVuHtXSyeai2lTk6VC5SXyi3U3mnjgUZq0amPJAyRMV8xa+ybrJEd+c3xDxgkx9YmJ6nX36f3LkZrxoxAA7OC9sv2E6fKmkgu4uXmfzpQN7+Rmxyz63yPeHy3IdDvCgRjsSW+ObaUqo0V8P2dBBEPyH9SX6TOnea8JWQCs9kQrCTp4aFMaD5aotD2vu0XFFF/elgeMUd4ite4jLXLG5ntdUGNg52D2mBEYpn81FYaa+fizw6y+zxuTUj/uiBYViXPeywHieNWZNVXvQ0PJjiLTTY72whCkzzAX/mogzn8DYKogfeocMW14+QIPE1cQwRclGaTAK/dgTVYkoH99L3Nq3kJYFcM8OXBrAMJkpoPjuKoaNwD5KpiGGFgJt3nb+W9IPQmqXINucFcikM9FuLcqwzgfAihQwhfFOMT/kU4GlYVbkKHtFJyZeDIvi7RNR49GSZNiLEzQOC7Fldnv78nj3ydas1Y+uEYFwEBLtmiRWlNiWzQjRgPOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlhQRi9tYitxeXRWcmJKUmozZ3hDRTE0TVlpRllMYit5dldPWXlzdm5WbitQ?=
 =?utf-8?B?K2Q1eFVPL3BjckF5V3dxdDhwMGtBNE9XamNRZWMySlZMZDVLZitQZUk4eVJX?=
 =?utf-8?B?Y3NZSU15bmhOaGh2NHZrM2hrbUYvcXRiS3c5dmJJOFJhb2FDUDVidWt2bzFw?=
 =?utf-8?B?WERMYmhWb2tJWHFEanU4Qk1kTTZjUGlhOVNzTi8rZklVb2JwOGpJdmtBVG1D?=
 =?utf-8?B?bjAwam04UDVMSlBlZjNoZGRDRG1UODVnaERXRE9Xc0NLWWo5L2hMZ1NmeXFi?=
 =?utf-8?B?d1JsV25WbGhkVjhla0RkY1NvTmRNQTVhaVhGWlVBR09wSnRuYlBFV2c2aDNI?=
 =?utf-8?B?UWtqcmkwSzlTV2FXZ2YvYnNhQkY4K1IvZUF0Tm9tK1gzLzcrTzBlaDBMbFRv?=
 =?utf-8?B?THVCYWNTd1ViZTV6clRlVUNCUXZDVUZJUzNjVk9pTnFINXBXWE5vc29NV01C?=
 =?utf-8?B?NGJucStibUJlNG9JdThvZjIxa0VqMHFtbzFKbE5kUENMeWhsdDJXR1ZlQlJL?=
 =?utf-8?B?MjN6Mk5nRnZDeHdETWRCWGRreXJGOG40bFE2UmtyM2xUOUpYY3RXUFpDSHV0?=
 =?utf-8?B?cmRvTjdzMjlQUnY2Uk9XR0o3WTUyTEVEWmU3K1JRODBxcm5JbG41YnU4TkRX?=
 =?utf-8?B?QVRHSTJlU255RnoxRkxUNWZiMVJwN0MxdmtsWkJLQmVSTU9LWUxEQjJKNXlu?=
 =?utf-8?B?MnM3dXF5VXd6YkNtU3ZtTGZoNW1oSngrbDkzZS9BRzhwVWFFaThmTTNVU3lm?=
 =?utf-8?B?aXFoR0JiZ1FuSlk2Q3d4VHprSFAxVi9vblpORnBCS0pzNjdtaDYyMHV2dWRX?=
 =?utf-8?B?T1YwK0NNSHZxUndJdFBnSkE1TWEvMXppaitKekMyb3gwUThLY0IrWnJzMW1T?=
 =?utf-8?B?RVpqN09sZGV0Rm1ybmxhQkRzSU9kck9ZRG9GL0tGeTVXZHUxUjhyK3NLbWsy?=
 =?utf-8?B?RzdWQ0ZtSUVEVXl0aDMwUk1pODk4OXVPeWNVNUlMeSt1LzIxVG1LRkhWaEV4?=
 =?utf-8?B?SU9uMUl3RmJLZ2tYSzJaYlFpdXJmclZ3VUxLK0diNXJTeFFjZFpwTEdPOEY2?=
 =?utf-8?B?eDA2V3lsaVl6ajlVek44MVNXT2lsdVNxcEJFdnpUNXdOZzltMlRubHpjbEV0?=
 =?utf-8?B?c1JCenpwTWltTHVtck1XRTRZTk13U09rTDJJM0dHNTZ6OXRjTm1hVTdqQWJN?=
 =?utf-8?B?UjkxU0pZM2Vqd0xLWldtK2VhWllaS1RMWU5ON2s1SlNVZ3ZDWENCS0drUDJ5?=
 =?utf-8?B?WC9xNnpGMXg2enZNd04zSjRNZTBUMzR6cXBqVHFYMm9TbEhJVjVzZzRLRUJq?=
 =?utf-8?B?ZnhBaisvNXg4MVYvU0Y5VVFtdkQ1K2REOEVSMHVKUDNscExMTmxlZitiZ1I4?=
 =?utf-8?B?bFFyY0tWWHVjZU5zTlhDMm5ob05LWkQrTExscHBOYzIyUERybkh4L2M5V1Iv?=
 =?utf-8?B?VEx6MFo5NVdoUS9NdUoxbGFCQkJ2WDhidWJUK3V1cjljcloxYUZHL3lUR3Jq?=
 =?utf-8?B?SVU0dWIzKzV1TjZMSDQveXFTU0tkUkhCZHVoZWIwM210b2RjOW55TG9oZldn?=
 =?utf-8?B?YnRheGo5THdzN3RuY3ZWS29jRHZDbDVEWjJadmQrQ3k3bFpzY0FaNms1M0t5?=
 =?utf-8?B?azI1V3I1QzhoS211WVBaaEp3cjBIQVhqckVLaU9kYUtFU20vdlp5ZDFUd015?=
 =?utf-8?B?b2Rud21iV0QzVE9rN2lNSWV1LzNya290OGFIWk5BWURlMzRpeldLSklBOVJs?=
 =?utf-8?B?anNuQ2p2WXZjakpsYXRmc203UjNweVQ0WXJxMEhaY0FPRlp2bTQ3WWpQL3ow?=
 =?utf-8?B?NEVZd1lhSytJTmw3eW9HV1JuK1BlMDNBNndNbzlIL1lPWXBjK1ZkditCVHF5?=
 =?utf-8?B?NityMmQ3czlYS2hCaUZWWEt5aXdWeFh3MWhpSGtUUDM1amt0c0l6cUprR3A4?=
 =?utf-8?B?VG5jbk1MdkVna1BsdlVTdVl4RHpVVEluWVZEbVA0Q1FkNUpHUWJjdEJrVjBK?=
 =?utf-8?B?SmdLbmFZRWxjR1cweG9YVnBOTGx5NUY3YU9xVEFyaWtkMFNpcXUzOVNDbEdJ?=
 =?utf-8?B?dFZ0TXRMS0tLV0Y0a3F0c0hDY2Zka2F6QVhGQVdSdS9KTXFZOGE2VmdER1BW?=
 =?utf-8?B?anQvMVdpamNuVjB1NFNSVjQrcnZ6djMrREdmSEx3SUFvRHM2T1UzWTQzWlQw?=
 =?utf-8?B?R3J0SlB6QXJRRC9EYVZFOGdFajBkMTRCbGVQQU9FdmNQcW5TNkFJdndlUnl2?=
 =?utf-8?B?RzhjMjdRVTZaRmRsMEE4VjgrTDk2MU56N0phRk1xbjNpT3J0WTdSWmpJb0tO?=
 =?utf-8?B?OFR4THZMV3lzNnVTK0M0bFFoRXJ3Y2praHhQc24xcVNCMndud1ZIdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43463c31-9e6d-48da-a84c-08de8f679ccd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 20:53:51.0911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnEpXSPNARjTyRdybWvdN4tQcuyAn3kmCcyx5dohkh+BAkgTE3gdmng7gUOC4RzBg4l/xpzTsBZJsTIjsioRsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882
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

On 3/31/26 6:36 AM, Danilo Krummrich wrote:
> On 3/31/26 9:56 AM, Eliot Courtney wrote:
>> The current implementation does not actually set the default values for
>> the fields in the bitfield. Set it and add a test.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> 
> Thanks for the fix!
> 
> Please add a Fixes: tag and separate the fix from the newly introduced Kunit test.
> 
> Maybe it is not worth adding the Kunit test in here as generic bitfields are
> being worked on, but I don't mind.
> 

If there is a chance that we won't need the Kunit test eventually,
then please either delete it here, or add a TODO to delete it
when generic bitfields cover this.

(Kunit, like any other test suite, is easy to add to, but also easy
to avoid pruning--and so over time it risks being full of tests
that are redundant or no longer needed.)

thanks,
-- 
John Hubbard


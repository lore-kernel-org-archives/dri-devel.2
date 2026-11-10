Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9CC60A260C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tt7KzPhU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3403910E8FA;
	Tue, 10 Nov 2026 02:55:43 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B3F610E91D;
 Tue, 10 Nov 2026 02:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipT3SU543Pq3QuZfjCvzGJzLzh+XwrX7ps0Hfw1kh+T1ivCXXfRXVhmcS+49aJF6eGUnQOBbfwq228s1PHZ6GF+QvKZKO6stbxTmh/6hsQgR0EXvcdb+UZcVw6mR1XqTFx/NhGzD+6LIgb4YCk+4OsxIfSsNECd9Hpodd5X4YUgq/wKuWYBxCiMWW0Q5UDRRQg1Y52xWJjGy5ioPCP90EaqIiwibN+ugQU50I0IOewctglcADzRdZpTytRHvehublpbDpoojK+gcTMWZ8vduQnetAeX2uKc1yRgsQ/99DmCTaBRf/jOoSEJJluDeoCn7qOCSTjHhKCmkeG9ZCbcCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37ccdoBptVI6iyLo021ZUwPL8MIZhXtRuW3kBBbfiFA=;
 b=dWyuH6vNFc8zN3xHWCVJ6+/1EsFH9/T2c9ASTuCOcfPRgHzGTo2g0Hq5RlbMfKO7cGdclTTUkGWkt0kBcLdyfh7hIXgKbb6jlLEJkHawKXmnmVzxJkWROWMJyHbowho2ncrtCtw9JeNMVr+WbCmhe5b/W+5J/Q+XgKY9Tmxd3pkQIvW47NOeDT2aXFtZuNjcZtchXJOhxHPXO763t5f8GYWFk3gTtfMfnTia+EG4sFIMk1FDZSGmhXvJ5JgGg2QEx0tG7C+uw+KK0+wsMXykSpu2RLJP5rZ5FLph7GvoNC9JeNUjOEOKGwA+fIfENiWz2zx6E4Pl7CGFx+310dIPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37ccdoBptVI6iyLo021ZUwPL8MIZhXtRuW3kBBbfiFA=;
 b=tt7KzPhUQAF96Ly7Vj3Ib7A8EvOeZ5sJ5BOZeDtuyaN4jsZhbKUE/GoyQZ4oNnwXbda5+D/U9RFoz9UVvMS97DEabg+2I8vr70u+Y7uf6NfeANkVpiBCPgIPhoVe78sDo0asmJEYm69Omn200QV44GroOC8gFUx4dyA7UkZmBO4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SAWPR12MB999163.namprd12.prod.outlook.com (2603:10b6:806:4e0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 02:55:34 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 02:55:34 +0000
Message-ID: <5fb0964f-430c-4182-bc11-8a2ff35c4439@amd.com>
Date: Tue, 10 Nov 2026 10:55:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/22] drm/amdgpu: implement SVM attribute tree and
 helper functions
To: Aveline Noir <jm5905938@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alice Ryhl <aliceryhl@google.com>, amd-gfx@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 Felix Kuehling <felix.kuehling@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>,
 Junhua Shen <Junhua.Shen@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Huang Rui <ray.huang@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, Yiru Ma <yiru.ma@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-4-ray.huang@amd.com>
 <d6275052-1715-4066-9291-4f4cce9c017a@amd.com>
 <179424328378.201169.1999994927528686770.b4-reply@b4>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <179424328378.201169.1999994927528686770.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:295::8) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SAWPR12MB999163:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d46986-a9b0-4f33-788f-08df3ed6171e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|4143699003|56012099006|261021121427099003|261009223027099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: EaMr6xrGKOG6KyQu53VKw+5CnunYCE0jy1QjqmnYc+ED0V4MC+5ob3Db8ED7ydUhgiT5iU9h9X+xQ4b6ybZsGckXW8FTRHm7HgZZtLSkfnWZgy59iNYI1Cije64zrrwZWFYEJvVqtrc9IZxJV7FH9vUKR5qajSE2LjjmDOj39/OEyzoaaoSr9aB/ZzMAb+YYbQHdeU6A/Ag8Ud+E+bqDv5JXJkMuA9CwoglyteicrNZIPbiQPxsZfWKyCMsO9dHUle5laaWkBrRhPNj2M1NG+T9UtLSfn1r8ROe7d40PscDH/s6OzRTnG4//jUGIhYeAh0/a3b9cuQjUBRuxNXJjeNToCbkgE3PXxxfrXaLRkvNeu95sGAv2wwaTn39n0NUQeV/tO+H4ww+Y+SFZIzq7oNf5Cvi60UmqCI+xH3xmasLC40oZd4xNIt+Ub8rsYA3H0ChU0ewusZmHQVHVWyF+f7m5SG66IjiNefD6qkXPgaWK3OBADroaWdFZu1kMcdnyRL7isUyJfVhgzfLRUu994C6LSN+xWMl+UC7oXKwUr+LzenquQ51fooLqpPkXGtNtvW0z5N/w4FQ7W/isYu4bQiGPsp7K5pNvecvRqnFROgsLTavTLrN8rbC1T4L6OtnoBAauWW8EcFW2/zlHCfhHFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDlWV01kd1BHQmtaRlpsR3FCYXNmMjRYT0ZTTW0yNEFhbU1NVGZlS1ZJQkRs?=
 =?utf-8?B?NzFMRzErQjdESVBUWldyTmNWYUplSXpOYm1lQVhBdkZhYWJhREhSemdBdU9v?=
 =?utf-8?B?Tk4zZ28wYXVIQitObSt6UW8vVWlvc1M0eENyd09zWXdWQlc4UXpSY0dPM1Y1?=
 =?utf-8?B?RndSaXgzdVpLZU8wcjhoOStNeWxLVkd6TW5OU09lV2k3MEo5V0l2M2RPVkU3?=
 =?utf-8?B?a3Q0YlJkZUtvVTc1R09Uc0NHSzdHejR3dmRQMGJxaXdpNDhuU0prcnZZV0dC?=
 =?utf-8?B?Wm05V21EODNQNWdzMTBLOFVmVkMyZ3FJSS83ZlI5NlVPTktJNkV5b2N4dSt0?=
 =?utf-8?B?WmYrUFR5YU52WGRkbUxLcjlzWGRCVWQydjZibFF6KzlRNWpiS2IzRUxIdVV1?=
 =?utf-8?B?YklPdHZqbWtCejJzRXIrSFJCK0VwTENjQWNlNWN5RHRFazdyNnNTUmJFbEJW?=
 =?utf-8?B?UTJ2SnhkSWFVQk9LYmRybzh5bUZNYUsrL0pVWWkyLzM4VG0yQ24wZS9Sb2xN?=
 =?utf-8?B?aUs2SElUdXdCNVY0aVd6SmU2VEZEM3JpK2JVZk5EUFBxRE0xTklFalphYzRC?=
 =?utf-8?B?MUlvZTJqLzVkckhmNHdPWVVqZGUvaWRsRHlQckd2Uno3UGJUTUZzVnlaWHJL?=
 =?utf-8?B?NXhZRVE0bVVIeEp2RW9FUHRVNjRVUzV2M2h2ZkxkMlhZM3V1TVlOZmExOXJk?=
 =?utf-8?B?QUJOdW5BUFQyNnJnaXF2UlY2SHhJdWljNEEvM2tGMXkwQlllc2U0WTdhYldt?=
 =?utf-8?B?MitsK1JQR2ltcFhVUnZKd3Y3R092dFRGZ2NER0hRNmNpSlAwQjduNWh2WWs4?=
 =?utf-8?B?TnIzZDlzWnlzbzBqckM3VGNXZzc4ckpSYmszMnpEaXpLZTJvNGt2VXN1UndC?=
 =?utf-8?B?cTJTNjZCbE9Nb2RDNDAyU3U3MTdFSXhFU2xPbU82bXRrNE5ENmJnaFdXTG95?=
 =?utf-8?B?eTZlUE5LN2F1WHpuT2l4MG0va1RISllrdmFxQk9aaWIwUTV1Y0QxTUxnaVVH?=
 =?utf-8?B?Qm9XUVNuMlMxREI2dzZ2bmZldjN0Qm9VcDFEVDVrQy9FaEorQnh0VFNydFRK?=
 =?utf-8?B?WXo5cXZucjdyZEI2R0VHb1NYQWhJVWNUdm1Ha2prN0I5aHp5ckVSNStqUUtz?=
 =?utf-8?B?Q1FoRDZRQnBkNFdNRFU0U2ZLeUwwdHZsZHRQbVREZ2dYTHlWeDkyWDJZdmVF?=
 =?utf-8?B?a3hQbmc1WEI2cGVwaDY3QWlQQ2x3SFp5T1ZOMmlibnBobFU1c1lpWE5aeUtl?=
 =?utf-8?B?VElsYXgrNEVrbk5TZGVseUVJdk9WL2FVdDN1QWtxeVNIelRMakVFSmJzeTBz?=
 =?utf-8?B?d0pMV1JZMU9RdUNQbWV3NS80QjIxRjhsRlhlMkYzeTNhUk1JVldYaDV2Tk1D?=
 =?utf-8?B?cHVLTnVhbWNOR2dBRm1yc2lUL1RHTFFEUlIzZFRPejM5OWpybEtWUGdLdEFR?=
 =?utf-8?B?SklNQmtrMEVUbEcyei9iMzlsVTlWc2REVElxMWp4M2dyYnc2MmtIVGNrQjFr?=
 =?utf-8?B?bGZ6YzVtbGRod3J1bU1SSnowUVZqMlA3L3Ezc1g2aWVzTFhsRmdPM01yM3hk?=
 =?utf-8?B?Vml5aXJHeFlrL3hwanE5N2dLRHNhOW1iRS9YZ2hiZXBaYTg2TnFpREVCSlQw?=
 =?utf-8?B?cG9QTTY2UWxtNTZSVEdFQXd2TU5nbGsvV2FUYjBzSWRLSzFKclR6TnA3MDJE?=
 =?utf-8?B?b1ZvaFB3aEQxT0Z3OE55QlZqTld6MHNQN3ZTTHdwN24xSVY1d2FBeWs1dFVv?=
 =?utf-8?B?cGQ4OTg2YVk1MjFsbUE1bFkyVkVMb3I2RE9mcytDbFp3c0EzaDJ4eUVxNGV4?=
 =?utf-8?B?U2NIb3lYYzBTRmhGaW5DNkpONTUrV21uVHlxQnN6TlI3L2M4UnNtek1jRU9L?=
 =?utf-8?B?bFJGTVBnUDh1Qm5MRHQrWndsN1J1TnZvMVhGSDFqTkF0U3hGOGFVSkh5bytD?=
 =?utf-8?B?T3ZhVnFLQW1jOW5rR3JJU2luald2OTJCS1VhSldSZmJPRENKNmJ5bEowdCtm?=
 =?utf-8?B?d3A1aUlPbS84Tm44bXNlZ2RWdGp1UUxiRzhiajdncUIyZXlFbjZ4Tms5dEsr?=
 =?utf-8?B?T2JMYkRQVXZYL1pyUDNiT3pkR1daYnhTc1BTakxJcVlvcVpCeFdRWkJ2di9a?=
 =?utf-8?B?aDRQbHJMeWhQWEFvYXZ3K281SGZBbWVvUUxKc0dVbGtpWDA1bVRKSTRxdDVm?=
 =?utf-8?B?S0FBWFBVc2MwVTJiNjhGUTMrc1N2S1J2WmR3UzgrdkdhRElhekY1Rm9NVnZx?=
 =?utf-8?B?aDlwb3RtRmR2ZFp0YjcwbS9RcytDWjVWbkxrSldFWmRENUN0bHRnRTdGNUFa?=
 =?utf-8?Q?LSUeexqBBjzuSS/z9S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d46986-a9b0-4f33-788f-08df3ed6171e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 02:55:34.3062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhdThtZ79Ylgu55ww8nqpPd6V0CN/anH2GvY5ap2U4p22zhwP8nAywJHSqeJ7EnTGrxM4/QqNJnjwEr1kSlBoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999163
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/2026 12:54 AM, Aveline Noir wrote:
> Hi Christian,
> 
> On Mon, 09 Nov 2026 13:41:48 +0100 Christian König wrote:
> 
>> I think this whole block of functions can be static, but not 100% sure.
>>
>> If they are used outside of this C file please add kerneldoc for them.
> 
> Several of them are used by other SVM files, so maybe those can't be static.
> amdgpu_svm_attr_find_locked() seems to be the exception, since I only
> see it used in this file. And yes, they should have kerneldoc, ideally
> with the locking requirements.

Will change amdgpu_svm_attr_find_locked to static, and will add kernel doc.

> 
>> Writing that I added Aveline on CC, it would be really cool if you
>> could take a look as well.
> 
> Thanks for adding :) I have some comments on 08/22, 10/22 and 11/22
> and will reply on those patches. Sadly I don't have a setup to test
> this on a GPU, so any testing would be very welcome :)

Thanks for the review, will address them in next version.

Regards,
Honglei

> 
> Thanks,
> Aveline Noir


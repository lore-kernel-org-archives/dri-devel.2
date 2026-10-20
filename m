Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE0606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RCGdAsAh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C33A10F25B;
	Tue, 20 Oct 2026 07:02:58 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA7B10E9F5;
 Tue, 20 Oct 2026 07:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0AurYY9kz6ZqU38ou7aKuFs5gCUXSyAcINvHEkD2TJLxq1eDTleeWqw+JtumHGI+cvkjUX43qLsdoc5fqo79id9IO0Ih/DNTl7Ta+RwuRj9+rXasFCkKcHdG/5JtUUzbrbQE3knTGbnPFr6GRZBlLFfUZmWJbDLxuvqfFEP18kVeM4y0LYhyvjsczHc13Ci220iHMitM4VV+q67DL+XhsWbOH36IHP0kvLvtOB3Z62W/FhqysSxMMWV6eNPEddEwYnetIYcKJWyZmXb7tOzmiDabwJ+T+sqeXigihrJs6Dd91s1gijNh7p/4DYy0xbtresvFOwe5Bj37kxvOABjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHdsKaxhMRTxnwkBqR/ncYUDwHokD5UmE7U5KEPUd2k=;
 b=T8SQLSE5O41qJBJvyS5fIkvCGhObUFDet127tFjuTppGEEmqGu+c7eugmIPdfuAdhj+rG8TgETREbo9/wxIAM+kbwoY3/SoBJr6owbkzSoVXesmo9JCRdqxIHbzRqJFR9Vv4Dh6Hsi3DoW/vc2fjubxu0A4rOjVAD6SExXzzCo0AGzK92tmVbRygsZ3EhggZpu2L92fu9QkU3/X6PMWzqd9DvfzY9+bPyeewSK+w0XEL7ZxxQ16m3szZKc9nfRpg1ICFGCsF7wSLM/ouT2736XQ2niA/OjIcVodlbCAWIZvZgvvn272qB8UQ+ByGkBRc554e0GElaH2qSBjH3dZeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHdsKaxhMRTxnwkBqR/ncYUDwHokD5UmE7U5KEPUd2k=;
 b=RCGdAsAhgZuPyytzqyLbc/UxPrssdvVYlJacjGakI3c96d7SdTM3KXPKZ6/pRq/Kc1g5H/UHvAAdLfYKWfnfPF6srfHwaTAHXgW7kuY5w0FM6XMGYN+VZCzjCpcgkuiQ13qXhg9aGe4Fbw51WDAPp3SpjhkGEMpcFCIdwJqncF8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CHXPR12MB999219.namprd12.prod.outlook.com (2603:10b6:610:2fd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 07:02:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:02:49 +0000
Message-ID: <367a13c8-1c18-4a79-a82f-12bb8430fa99@amd.com>
Date: Tue, 20 Oct 2026 09:02:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: remove unused cgs register accessor
 typedefs
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch,
 paulmck@kernel.org, rostedt@goodmis.org, ast@kernel.org,
 peterz@infradead.org, gregkh@linuxfoundation.org, abo@medichon.fr,
 skhan@linuxfoundation.org
References: <981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com>
 <20261017130047.42080-1-emmaonana18@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261017130047.42080-1-emmaonana18@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CHXPR12MB999219:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b25a79-51b0-4252-fe82-08df2e7826c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|261009223027099003|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: Z1mbxc8/zwjCTcZp6hLA2mZvJNvsxIBQQ6WK0h21yUqTzgMJouvmZ/MYwJ/u+/7KxY7JLZY8/tzMYo660VR1WHMZUXgWveE1QUGKB3I1f1XwYBGqSQmMG3C27SslXXoBvJG6BU+PrSfHxHmseoSC7ZGO5MbagI4S6/dQDN7wFZeWKF3tk0QKjRWLFbCOupttkM8dyV5w85I8hrzcV0LR4wkQF6EZkaNwSFX553UY3RLfr6nswQXgJIFa+E/yWqUYPD+FDVT3+6HcygkFqyg1aYxuXCDM/5n1Uyv0AoaZljUlR9dvyNsuQXCTYRCk7womRhkdCFa5txg7wFZUR2HtXCE8MqUwXsl3etFSNJBoMHkrRI4ECvdcg+Fnqfp1S7sU2gAEo1ZJ4vuQqvQ72zFpXdd5mJLPKOcDY8PFMlqadONDBNRaqIMBmEgIZ7cP9GwKuyo1xYChD1dH5qPsrxvrndtW4X4UvEiSzl0ZoZd4cy32uXXiV0chAKEzOvqTuRk/dDXwlugTUjBBFKDug6EJ36n4hROEzUPd6d6JSBl10D2y0sGmZb/xdmBdYUpTAbkrNw8lDG9nVkRW37WYidQV6y+8v6Vs8Aj0kAQn4ifYiWJf8zOCDSz8nQKFPLI9xBk9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NENiaGphTnFwYnFSYjd0RGcxa25MQTd1QWRLSDVXTkFCSE9aUDF1WlNnRFU5?=
 =?utf-8?B?N015alFSNzhSVWp3WXRZTCswZ3lyaUt1aEtPTVlPZ05VWXZnUk5LTzltMEt4?=
 =?utf-8?B?emwyVUxLbGJTaVFTYWpCN0FqUDRLVXBVa0ZQMUFpMEZrc0tYTlZraTMrMTll?=
 =?utf-8?B?STUvdkdWNksxTlpoczNzR3daeHN3R1J2c2RzdjlicHRBU0t5cit3UU43VUli?=
 =?utf-8?B?TVpyS3JYZHBwQXlQNC9rOGxHYUhDTDlDRWNEUHFCYXVVMHFHK3BFUHM0WXhn?=
 =?utf-8?B?b0NFNzdkVHZsN3V1ODhGTnZXR3dOVktlaDJIQnRFUExEZUd6OVZZUks4S1Bh?=
 =?utf-8?B?RjNXTVJDdDYzdE9lQlFZRmhoRU1QVFI5SnZxeDhkT2JKQ3hTWFNkWU5tV3Zo?=
 =?utf-8?B?eEtNZE1qTzlOWWlWcnpZMkduOFF0RnJrTDc3WHB2SkcrUUdTRU1rZWVnVHRZ?=
 =?utf-8?B?eGpZdXh6TzBIUFA5c1lZY0QvSDhnRVNPTlpmeUpuMFh1QkcwbmFkVmg4akF4?=
 =?utf-8?B?MTcwSlREMnFoYXIyN2tieUE4bDZ6aTZnK2MxbGRYbEY0bUFrZE4zTGt5WlNq?=
 =?utf-8?B?T0VjQUVHb1o2VGN1ZCtLZ0ZpRC8rdHhTU1E2WnFuNlFaQkhncWJWUmxVMEwr?=
 =?utf-8?B?U05HazhtbnJWVi9QSW9NdGtoNG5RRi9NbzI4NmJjdCtNdjl2VVdqc3lBbFlk?=
 =?utf-8?B?di9tOVpWakZ3cHlMbng0Z2gzNWFxN1l5NDRCVVJ4aHhMUTQ3d1dRVjJQRCtS?=
 =?utf-8?B?bktXS1Jyc2EycWxOQm83RjBVOEtnZS9QQnFlYWF3Z09NMUFZTTRMTHgvU0tq?=
 =?utf-8?B?aHFKQUxNNE5pWnNaZVgyejltMmpFd1lDbTl1N0poUkZiSk0xdXhoUXR5NU8r?=
 =?utf-8?B?endLWnJkb2Q5d3p5SUtuTVNyeXpQNHF5VW5GS2tFcCt1VE1pbElGVXdJRnZ6?=
 =?utf-8?B?c3JDckZhNXpMdy9RYWcra1N4VVBOZVBUZDZSV24wV0VpU0ZlS2N3OEhuSXdx?=
 =?utf-8?B?Z29GT3NGNDl6QkhZaEpoUll1eGs3amFJdEdwT0VyZHlibUNxbCtZc3lCWklt?=
 =?utf-8?B?dXJ1eFIyNGhka0l3VEdmbEVJZ1kxcUJIUVlNRkQ4NVIxRWFNQ0JtQzlVQXRY?=
 =?utf-8?B?QVRIczVYWnF0Sm9YQWNHTE5hZFhITU5VYVJlQVRqNzIwZW13RENiL3NyWnps?=
 =?utf-8?B?Tm91ejJ1UXBOUHpEMkFEUXRiY1NRTkNJNFdBRUtPaDl5QnRvTG9nQnU5RElJ?=
 =?utf-8?B?S3k0Q000Q1NPT3RLTzFMcURJSDlhNnFqOXcySEtsUFg3QTFNSHpxK2F1ODVV?=
 =?utf-8?B?ZTJPbit6S05xWUU4QTlZV20rQUpFV0UwU204bkFVT2dHa3BnQmxBckxMT0Q5?=
 =?utf-8?B?ajBDZ2ZLejBEOGF0d2JKSHFRY2E1MnhhYWM3ZUxIdjRkcTdiVEVjSUhrLzlZ?=
 =?utf-8?B?QzFVRmN5Y3A3dkllSnVyZzJDZUF1Y2lZZHFjbEhSNlRUeDR5Qis4OVRzdVUz?=
 =?utf-8?B?aGxHYkRrc1BIMTlrZHVkSGlGZTlOSys0ekJyS3lwM29GOStzeU9kRDk5QmFC?=
 =?utf-8?B?T3REdHY1dEtrUUtuUnovMTJhZTUvWExJeU5hMUNhajUzZGhJaU5MSHRvTXlx?=
 =?utf-8?B?USsrdHVlM3pyN2xjVzMvUjkzQUxJNEg0WlVrK1RkVzQ1U1NNcEN0ZjA5OWtt?=
 =?utf-8?B?OG9kaDJhajRMQTJTK0xmWjNiNnYzdnE2Tm5JczNZT0xjZHlkV2NxSFNmVEJm?=
 =?utf-8?B?Um45T0ZlQ3oydHRYb2hPTVF3R0xaV2Q4UmlYUXF0bFhJem1zSW8xMnQ2eHlx?=
 =?utf-8?B?WUdSMHpucVh1TWl2SUpwbjV1L3JqditXek4vTmhwSlVMTTA0cFBVeDRQcEtm?=
 =?utf-8?B?S0pyZFBvb2ljSE9rY0VFODZoN3JZdGNjS21JeFE4ZTM3eVoyZ2VjeUhId081?=
 =?utf-8?B?cXhPL1gvRTFMa1BLSVZNMGJUWFpzSzVOYWpKMDZKKytSY3IxaTVqdlNTZnFV?=
 =?utf-8?B?OTloa01rRVpSdGxFZ3J0VVVFRGVGZEZCWndNYTdnUDlvN0lJMm1DM29TY1o4?=
 =?utf-8?B?RnErb3I4YklyemtEek9NTmptWnFEb0oyM0NLV3VNclRSRHpsMXZvdkh0YndI?=
 =?utf-8?B?Q0pUVnc0MjVPd1ZLSWQ2WElrT24yeTU0RWZJZDd6UzlFMEFHT3B4aGFzeDN4?=
 =?utf-8?B?Rm82UklPZkJHWjlVeGRnWDVidlUzMTV6Qm82cjRqVDA2NkFIUWpHL1pvTktV?=
 =?utf-8?B?RlpmOHM5QmJMNTJNMG52bXlXa2FDd2k5dU44VEdaU3VUd2l4dC9hWmlJMlQz?=
 =?utf-8?Q?UIDPDUzAU8NUyEc++R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b25a79-51b0-4252-fe82-08df2e7826c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:02:49.2234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jT/NghJk113h5uh/NSOnFORyt6t9rbBUE67FBo4MS+DCYUR68kkPc9SXAAyc690
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999219
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/17/26 15:00, Omokefe Emmanuel Onanaroghene wrote:
> kernel-doc reports prototype mismatches for the cgs register accessor
> typedefs, e.g.:
> 
>   drivers/gpu/drm/amd/include/cgs_common.h:89: expecting prototype
>   for cgs_read_register(). Prototype was for uint32_t() instead
> 
> Each of the four typedefs is used exactly once, as
> the type of a struct cgs_ops member, so they are merely an
> unnecessary layer of indirection. Drop the typedefs along with their
> kernel-doc comments and write the function pointer types directly in
> struct cgs_ops.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Link: https://lore.kernel.org/all/981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com/
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/include/cgs_common.h | 60 +++++++-----------------
>  1 file changed, 18 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/cgs_common.h b/drivers/gpu/drm/amd/include/cgs_common.h
> index f40b6a03fe63..1750401c7d08 100644
> --- a/drivers/gpu/drm/amd/include/cgs_common.h
> +++ b/drivers/gpu/drm/amd/include/cgs_common.h
> @@ -80,43 +80,6 @@ struct cgs_firmware_info {
> 
>  typedef unsigned long cgs_handle_t;
> 
> -/**
> - * cgs_read_register() - Read an MMIO register
> - * @cgs_device:        opaque device handle
> - * @offset:    register offset
> - *
> - * Return:  register value
> - */
> -typedef uint32_t (*cgs_read_register_t)(struct cgs_device *cgs_device, unsigned offset);
> -
> -/**
> - * cgs_write_register() - Write an MMIO register
> - * @cgs_device:        opaque device handle
> - * @offset:    register offset
> - * @value:     register value
> - */
> -typedef void (*cgs_write_register_t)(struct cgs_device *cgs_device, unsigned offset,
> -                                    uint32_t value);
> -
> -/**
> - * cgs_read_ind_register() - Read an indirect register
> - * @cgs_device:        opaque device handle
> - * @offset:    register offset
> - *
> - * Return:  register value
> - */
> -typedef uint32_t (*cgs_read_ind_register_t)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
> -                                           unsigned index);
> -
> -/**
> - * cgs_write_ind_register() - Write an indirect register
> - * @cgs_device:        opaque device handle
> - * @offset:    register offset
> - * @value:     register value
> - */
> -typedef void (*cgs_write_ind_register_t)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
> -                                        unsigned index, uint32_t value);
> -
>  #define CGS_REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
>  #define CGS_REG_FIELD_MASK(reg, field) reg##__##field##_MASK
> 
> @@ -137,14 +100,27 @@ typedef int (*cgs_get_firmware_info)(struct cgs_device *cgs_device,
>                                      enum cgs_ucode_id type,
>                                      struct cgs_firmware_info *info);
> 
> +/**
> + * struct cgs_ops - Common Graphics Services operations
> + * @read_register: read register value
> + * @write_register: write register value
> + * @read_ind_register: read indirect register value
> + * @write_ind_register: write indirect register value
> + * @get_firmware_info: get firmware information
> + */
>  struct cgs_ops {
>         /* MMIO access */
> -       cgs_read_register_t read_register;
> -       cgs_write_register_t write_register;
> -       cgs_read_ind_register_t read_ind_register;
> -       cgs_write_ind_register_t write_ind_register;
> +       uint32_t (*read_register)(struct cgs_device *cgs_device, unsigned int offset);
> +       void (*write_register)(struct cgs_device *cgs_device, unsigned int offset,
> +                              uint32_t value);
> +       uint32_t (*read_ind_register)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
> +                                     unsigned int index);
> +       void (*write_ind_register)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
> +                                  unsigned int index, uint32_t value);
>         /* Firmware Info */
> -       cgs_get_firmware_info get_firmware_info;
> +       int (*get_firmware_info)(struct cgs_device *cgs_device,
> +                                enum cgs_ucode_id type,
> +                                struct cgs_firmware_info *info);
>  };
> 
>  struct cgs_os_ops; /* To be define in OS-specific CGS header */
> --
> 2.43.0
> 


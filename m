Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E977606A327
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Im076Dgv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8656110E274;
	Mon, 26 Oct 2026 06:30:04 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D098B10E274
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSmPvYJ9tujYlpb2JBxk5iz3+ytwJb4bu3orp9UDXJk35LPJ6ZS6oOtS9vL0RKjkEztMCwvS4+cZZEXZJsDYuqoHeRh6dQ/O6Z074QhnxgW59W8pr7N8so8TLbfKeyw2WN9zjwTAF8wnAAL4+zfxBXzDVn4BAyGc/1Qykmx3MYBV9lwW2YHX38ZW8fqribNp2Gi9ZSYgb4zE5QiLXUQtH/txT9C5UUfcPnUR9rGorskSIq00KO9/N0q1dBMQGIhfMT4fFMOplGQpW5IMFhwzLxAwjvAtWlufedQjaF1nGHIqzXiifJdH9H6RrebT1fr8aqsn1lcw77Q6aFWP0xKg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJ+r5BuY++71jnVN7z/L3mp+0VJcax624DEjS1BUw6g=;
 b=pwkvlzfJ1rR3hQBU+sAnomKMOjMHG28QQGSg5OZomfAx/9GgeIhlTHtqZe8UcF3Te4OBO7W7gtTGcj0W6l1VmkT2sSI+P8cr0BYyouIYH+LBirOsfeo82NzoyoQNBwhEuhsStdxQh+F4M3iZEGuYVU9pMjbCz+a5vnmUWTDK1VkCFvbcX9uw8Vq+hF/tDgftpQz35lqsAR0JGyh8uBTpTk5XZFoxFl5RLVAiSSvqnGZqqL9rGsLtPHn/HflinEph5ifNNTH/dXqqhtCvU0jJ/tZxn28trkepuGg+Q4dxr1+o1zFLvszqu17j8sWWg/p+CXVUDdS3grqAuj8dGRrj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJ+r5BuY++71jnVN7z/L3mp+0VJcax624DEjS1BUw6g=;
 b=Im076DgviQwbukmVQF+nHM2QJA2G3dW0jVkQZn03DAOAAoplngkzM29lk64Wjn9PcW/fNltziWS2n9cWLGaWM9sGaIHm7zzApTpWXjSJiWUPdgae6c37lQjV/VKg2q2blq+RQ+oTNxS7gFkXvg/JYFO2stkfcb2oWFTqXXBenaM2OYwylzxywsvC8ZQVAcNNX+1fJuH+NK10RivPxAJZr0QjdtcmnVkpeGWf54GXk2XWUBNzJuKxpfIzfhJAD8vo48h4Ad9Wiz+U3nvdTZvHoP/AJhhd+egB5VEaOzfNiJLb05UHrxXdhY7N8vAXilY8CJpI4vMEdWRyy3Vv+rewuA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS5PPFF8845FFFB.namprd12.prod.outlook.com (2603:10b6:f:fc00::66a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 06:29:51 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 06:29:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 15:29:48 +0900
Message-Id: <DMEK3PUEZ789.11CD6YI4YLYP3@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 4/7] gpu: nova-core: add NVKV decoder
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
 <20261016-b4-nvkv-v4-4-e8b92b91aa5b@nvidia.com>
In-Reply-To: <20261016-b4-nvkv-v4-4-e8b92b91aa5b@nvidia.com>
X-ClientProxiedBy: TYCP301CA0028.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS5PPFF8845FFFB:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a711061-f2b6-4c97-9f4f-08df332a8a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|10070799003|1800799024|5023799004|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: PS1URWjl1Lv47nomReFQxi5zUQaZNu/cxU4EGmVnvBNPZF7XIHl5zQeMYXJBrZzJTujWKyOt8y2Py4EeohJEDc6+0pc2gBDHWcf9pTXFLAkfLrBqD0b6PHosL2u3CswKhFP8dtIIGkBjahuV11/Kd3ppboWOB0qdZFab7K16dhx8X9XRnY/gWUXdpDwsY2YCpsXrSV7M7v0/oSt4U9lz77qhQkcYfIl2DAKtgLy8BlwzAIKQDw5a16b2HFwZktz2tqNvcrMo6dHo2Gb6B11roQ8amAJZL0I7DHUDroXJX192zaotI1fxIyixopCty4jW992BJm7tmaxifXWflXL5J07OjToJE8dPas3hI6j25Ga9FCYiksLHl8jjd4EQeMtUdg8wUrmm/auOtNrJIkc0uNiz67VVtWv9eWTUVggMcU9/ftC5nt7jUE48Z/O8xLPrRdNbskpXlGjxKux9MD3hiyLoW3LJfJ1lcq/z8vdW9OUS0Nzy46ZKVqIquQ9qD0mWUo/IxhMmQN9hz7qGkLYtX1pZ4JH96j0JdhIXSwkJtL2LOsqvVz/GADeoqd3XSvCP48bqVuFE7wuzDdRfpeqAT9oap3l7hGRr3o/NqkLWszU7hmyVk3GgC/YuEn10D+SXuT8TA0ffTQIOrmWWzKE253lLKZKGpKVe0bchWgS3shk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(10070799003)(1800799024)(5023799004)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlphR1ArTjVoaXpHczAxc3g1dlBKNnZTZHdoWnNqZkl6UWE4WUR5a0NvYWE0?=
 =?utf-8?B?YU9BOGZ5eTVaT1EwQ2RVR1VPSktVSmdHM2JjQU1yY21WUWExOVBhTENsVjdn?=
 =?utf-8?B?b1Nkc3Q2K0hIVDdqMExiM1Y3Uldzb1JqTHl5Z0pqMkZFeXB0a2lETlptZ3Zo?=
 =?utf-8?B?R2lxNWFsZ0V1cmhjWFpiUFRTNkZBcmI5UG1xQWFDcTJ6Z1lNRkx2ZFVCYTAv?=
 =?utf-8?B?TGg2ZkhWbEUybVJZSCtnQ3dabThpVVJiY3pKLzVKdExHNko4OUFSOWltV2dS?=
 =?utf-8?B?RzUxbnl2Z0tEUUhrK1Zvb2xkSXpPdlVWSUljYkJTTi93RnJRejE2RWdvRzZJ?=
 =?utf-8?B?b3I2UHFucnNmRkU5VFhIWXA0Rml0M3orYkJsZmlXM0JZL3I5b1ZXODZSNDBp?=
 =?utf-8?B?SzZxamZYNVNjTEkrSXhOem5iaFJOVjhwYkhCcHZ4VW55cUh6WHY2MFFNMWkw?=
 =?utf-8?B?MjRzR09WRVFRM3FVa1hqS043T3VrendCVDFldldTbWNBa0ZENEE5RDZzY01V?=
 =?utf-8?B?VFFIbXBmRk40MWJ1MU5UbTlDUndFUXpNQmw1NjFvY3RzQXdybnFTQ2VhRUMx?=
 =?utf-8?B?UENaWm9sZkVMVmE2SXZ1b2pyZVVGNGFWcVo2VG1ZcVA4TkxDZjlIR1cwZTdF?=
 =?utf-8?B?cmJidk1hU0N5dDl2czVNaWdWNWp5RS9SYlRwMThGejlkOGtrbUhPSWFGaHR1?=
 =?utf-8?B?UjRkUFpkTDBCb1phVTl0NGFDeGFWVDl5Q0xGS0hFSlpQazBlUWtxK3AwaHVv?=
 =?utf-8?B?ZGlySVBXN0hRNHVTcDFSOGJJUXpiWC9NbTZNZ29ZaUFpeXpQZFpsRGVIU3VY?=
 =?utf-8?B?Skk1MnJBWGhVK2JnN1lmd2xzLzdQZHNoS0pUMU5vRll4eFhhcVhYb1ZjU2xM?=
 =?utf-8?B?R1J5UGtxM2w0cFBINzBpM1Jpb041aXd1NjZHUm9zU3hvREFvQUFvcmYwdFhL?=
 =?utf-8?B?SnNKbWQ5ZzVGMkNqblUzZ21NbiszTHVvSENpRXFCeEFFYVlsU3JyWTE0QzY1?=
 =?utf-8?B?cXNvY28xWlltaFE1YTdIRGNTa3Q1NDlYTDUvSkJGVU9ibFRkeFdXc2x4RXpJ?=
 =?utf-8?B?T2Rja1k2N1BldFZrQU9yUU5CVFgxWUNJR1U1TCtMQnVxWC9LenBZUzFJZ1pr?=
 =?utf-8?B?VW9tL2FDdit4aGNEQm1sOHc0eDl5VmlpSjhkT2Z0NUZJdEI3amV6c2xKSm1W?=
 =?utf-8?B?a3Z2alZKdnY2SWI0c21UOElKNDdCUDl3YXFFY3I0RWFBT0V4M2ZlOHc0Z1dt?=
 =?utf-8?B?eXlQTkV0RzByN1F0UStEMWpaaTcvUktpQnlaNnhha1paL3hPQW94OFRzbSsx?=
 =?utf-8?B?OXl2MjkrK1hkc1dML0laK1U2R3RITGYrbjU5TkdHWUYwQURsdG9SUVA1Sk9k?=
 =?utf-8?B?TmNRUmJXMTZQYVg0RGNVck9CSGxnMGt2WDMydkFlKzA3Nk5OZUZTbGU2SHdZ?=
 =?utf-8?B?OFgvTFVKWE1vL2hQdkpJL1h1SzlMZGpWc3lKeVB0RTNUa1hOWWNlVEVaanVt?=
 =?utf-8?B?ZkMwNWVnUjZWbVBjTWloY3VUS2c0VHJKVVdTYzNMdmJ5ZHp4REtxaFlZV2hB?=
 =?utf-8?B?T21yQ1ErMHpaaU56WTJTeS9NRlZYMlNMek1RSkdQbXhydHFXbFh0bTg4RzB3?=
 =?utf-8?B?ZlpnbWJycmtmK0oreFh4MGxhcVRPeDJmVGJGeUtmbzlzVEhnU0VmaktWZkxx?=
 =?utf-8?B?U2NpaHZFTDNGSGJZOHlobHVhK1dJcUdGdDN6bFpxQlJjSkI1dHhTZkJJTUpP?=
 =?utf-8?B?NEFjd2JFcWg4RDRGSnZhWnNpRTZ2dC8xeWhPRllaVTFMYjdoTmNBZUFwR3Bn?=
 =?utf-8?B?SXI3MG0vK3c4MVM5OTlqUE4xYi8vcy90RzA4VFRIbVdCSzVTVjVaUEp1dVVR?=
 =?utf-8?B?SFp2Y0NUejRDVGRpNEltY1NPd1VQQThGaWFhRURqV3BiKzNVRVliV25rb1Mx?=
 =?utf-8?B?Z01TeC9keDVwd2F3YXRVTG4wb2hXcEhOcUVPdGZkc1JPOG1XNEJEVTF1S2pm?=
 =?utf-8?B?MkxiWGs2TVp4WVpwcWRZMUk2VUFwNFVRamRzaHh6QkdPR1hqb21DYXhiMFEv?=
 =?utf-8?B?R2loTjB2aDh3R1RnbEVUMjkwMWo2eGo5S1pGMGFVdEdCMVY4bUFKaUk4WkhI?=
 =?utf-8?B?V2gzVTJyQVQwbmRVTkV0ZGE2alNNVm5kR0toM0oxckZzeFhJYjVpbG1XSXcw?=
 =?utf-8?B?YmtBYXFtRVhyTU9UMitDQ21Oc014TFplQUZnQzZyeUhvcjB1ZjFEZWxQV3Z3?=
 =?utf-8?B?ZG50WkRTQ1RrYjI5QjcvcnJlVzl3amlXRGZUL0xJVTYzbVNEY3VRYUkvdllX?=
 =?utf-8?B?b2d1NEU2cGRLaDdVdjBJaE9OZnRZMS9PN2NBRTN5aytWSTJ6VlpxbmtuNU1y?=
 =?utf-8?Q?jSOOsgbsChNEP0s6ZwTnWPGzJK2IHpRpBr7mUx5o2gfNe?=
X-MS-Exchange-AntiSpam-MessageData-1: 3pCJRiW8DqqQFw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a711061-f2b6-4c97-9f4f-08df332a8a3b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 06:29:51.1933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lX/K/KYP3Pb30IoUS14ogNicJX7q30tFBGkKGgIxP2mz6dH+EJ1YjDVxHH6oq47WrLoykv6viOCR5MbKR21xJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF8845FFFB
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 16, 2026 at 10:53 AM JST, Eliot Courtney wrote:
> Add a decoder for NVKV. This is for receiving messages from GSP for
> GMCAPI calls. The NVKV format essentially encodes a sequence of function
> calls f(key, index, value). This decoder reads an encoded stream and
> invokes a type implementing the new `Schema` and `Visit` trait. The
> `Visit` trait can either consume the value or not, which is useful for
> composing schemas. If a (key, index, value) is not consumed, error out
> depending on `UnknownKeyPolicy`. Whether ignoring unknown keys is ok or
> not is per each GMCAPI call.
>
> Add kunit tests for the decoder.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

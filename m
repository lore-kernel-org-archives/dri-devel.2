Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24420606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=aCDS0c6r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D0C10F08A;
	Mon, 16 Nov 2026 12:50:03 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021098.outbound.protection.outlook.com [52.101.95.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D0510F0F5
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUkhAGjYG6EgwSt4AJg28LQQNUr65lKFnnKe4EKdbCXIyPinSLJRPrhr+6x1Ej2SSiLuNPBzyetbanfUGQcMaQJXKGWp0sw82QRyCGIuhsCs8IcmNXLifyXGCamkmhpwiFskkXQlp4EnstkjUslG5MFQ+FmKIrpKSe6LmFb9iQXoB+LcQXTmQzEjvf+hr2xVl6gR3zmaKtGUMfh5dfP6Mvh081jh5Z7l+pKZhVzOSw66h9QiB7BjU+ItAFlC3XntfnySL0DXHxNKgAeayvzFex4aE2PiIEoYKhB2vxmj4aOnzCjg8B1k4EjOpDu7yboYmpIn6iPHTKynO3PcWg7mSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9CuFVGuioBjFiuBaLBHOShLnK9MMCT2+Mhp35wCuLE=;
 b=WBhySmVtZAqzw3HLdmMSZeYw+vHqnewHC5K20yN1ry3Pb3dvvZBpQo4fcr6/qRIlhjfEVZrKAe2CiXjB3BjmNrDavhte37uf9zb5HGyD7BqZVz9ir4AlnV6ST3wjYiYZTDR+RLJBnm9wiwCRx2jcw6XDyv2qxeO2Wk4xf5P7HZsrZe/KgcpSbvasYTveG+7nMCSWo+zdNokkox1fkn2TRmCfEgFFktheh5MipUKoFzy/krWHVu3W894QWZocEpF5CdTbQPQRI0zTonAOW2VXv2xMnjgeSSMSZSeHYuhGQj7P65t//R4SC3T/8gOCczWdvnz9//c6mcIW5fqAqVzhCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9CuFVGuioBjFiuBaLBHOShLnK9MMCT2+Mhp35wCuLE=;
 b=aCDS0c6rOHtKF8XLDoXFTrQydd6nkgRn5GH3b1l3SGmVx9f8GP1QfuBqg0YsB/vl94wlhuW1yjzs0DUWS0W5XT2tZqZ1TA14YRJscewhTBlJg5L0iUwvbIVK4+UYKS5oz12Psj7uwbXwn0DpyXYCyZQ7c2r060/h0L2FYoxnLS4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LODP265MB503956.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 12:49:52 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 12:49:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 12:49:51 +0000
Message-Id: <DMWNC5DLYRO8.1WSI80QE8AOKH@garyguo.net>
Cc: <aliceryhl@google.com>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: scatterlist: tie owned tables to the device's
 bound lifetime
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261114234324.82387-1-dakr@kernel.org>
 <DMWC45NN5L9I.2NUG81ETBC84L@nvidia.com>
 <DMWN7AJF6SXX.1HN3UMDROET7F@kernel.org>
In-Reply-To: <DMWN7AJF6SXX.1HN3UMDROET7F@kernel.org>
X-ClientProxiedBy: LO4P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::10) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LODP265MB503956:EE_
X-MS-Office365-Filtering-Correlation-Id: 65652566-bdec-41ba-9e26-08df43e01b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|10070799003|10067099003|56012099006|4143699003|261026140227099003|261028144727099003|261022105027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: egAWxsYPUVODGxeFy4GPbFBe23wkBiMBWisJvg0Z9eE5Y0lwgpeqZiHef12DZ/5+MNRUaZKI2Eh6+xkT8Z+VT5t7mM4pbK9qnyGLv0mrBjz5iOI8faTFJuTfWxgYWzwDbHW6MIdqKVU0p/38Acng+JxqeCY+CzITYZfLuv7CkOrxG727L3k/xnU1sWsrpOugTvfYl2xzXaf4a+FNpcNS2jr1rKWcHRvqbfkGfJdQ5P8wSHnOWYAp6qzlAIKKDyE5hAtKWrcCc0Dh6Y8/gSODpfAzWdcV2d+6u82cgsXsNt6PgxG4LgLlxbRcApT5/tDBJl/A58TIXCntiB8wfdAaoQgUIEP5/0wt3DW5l6PbkLUCH+5cmJiX7dvkf+lfIUgCojgon0cHJ2j473UYJie5mhHOJPPrMt3oe0C+24OLTPs11IWZzrFAWc6kCelsnmABYjIvSI3gXmwK96ptW88D1UQ3849UrRuOLtC2Peh5mfX9ItKvwk4hlvN9wYzhHzN9JMRa6IBEvQCE8JknuYnhFOB32lMKs61yCqwJ8PwCI7loQZLpvF57Mltm6KujVJ3QDy+mbI4e1Rqe0wMJz1pFpp6rhGDr2diDUny0kB/DPmkGB/GxC+KwL1VyEGTm5/OiV0EcRPu3tSsQWUD1Kvt+aNYyUmetYEMWSYv1w8+8hx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10070799003)(10067099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261022105027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDRnUVpRaWZLQ1lWV0N4N1NpOVFiOGpxaW5KaHJjMnBOeHJ3YXlFRmJEaWNT?=
 =?utf-8?B?Snh1TkkzR2JCVmNsSkZtc1d4T09EQWUvQ21PMVVoQ2tnRURDM3MvaTZOMmxK?=
 =?utf-8?B?QXQ5dzdlNTlGWWZYaUNrOTNJUC9wZnF5SmFIWVpiZmM0azdUOW1QMW8ybmRj?=
 =?utf-8?B?ZTNWTHBYV3hHdzJrUGVQZU9UYlpESjJNS2dWdmhEYStrRkk5Mm5yM01uYkFs?=
 =?utf-8?B?MXRKcFRzdjZiSDd6dVhXTno4SENpNUEySFd5WVRBNDEyT0I5YmhSNUlON1hL?=
 =?utf-8?B?RWw0NHMzd2VUVHdlMVhXYjg1WG9MeU9HR09yQit4T2drRktTTC9tRnFNOHNS?=
 =?utf-8?B?NVRZUkJESURkMHVXVE05YTUyTnhNRldOM29JcEVxYTdic2hiY1FjSUVmZUp5?=
 =?utf-8?B?VkptZHNJUkd2M2FJaFhuTXZIOVJGeDQ0anhKWUlXQTFhUEtacmZVRjBtTEEz?=
 =?utf-8?B?bEdxeFBTR0JwRmtOaDltL05CNzhHMk5TRUt0S2l3RWxEU0VuSWltRWFCVGpv?=
 =?utf-8?B?d2pBZldyQWptKzBmbXp4ZGlpSzVGNGNvZW00VkRtOUhnbksrWmMxbVFwZUgz?=
 =?utf-8?B?eHdDaGRqY0pucmFDVnNiK2NlQzNCRTd6OHdNRXlKY3A2NHdaQllRS203eStQ?=
 =?utf-8?B?S2JKTkdGYWwwTjZSMGc2NVJOQXpQemZhWlRuY1IzSVhEQyt1WHRKTllicDJD?=
 =?utf-8?B?MldBSFptdEZ4TC92dCszU0tSWThZVlg4akI0eHg0VkVVTFQxaVM0MkM0V0NS?=
 =?utf-8?B?anQ4Mzd4OHpITWlMSGR5ZFU1MThWTnFUYUc2NEFEVDZHSk15VzBSYktPZk1i?=
 =?utf-8?B?Qm5nUHN0MnBKcDFFVm9VUGR5cnQ2dmVCdFF6bDNZM2JDc3ZEcGZ4U1NUbmo4?=
 =?utf-8?B?TFJVWXgyWmN3MTlyVWJ3UEhRUFBCR1FXdng2cTJteFovUVlqVE12cGU1emJi?=
 =?utf-8?B?ZE4vSnNONE9iMzhuaVUzUDdSS3JWaXc0RlBYNkI1UzRmK1BqUTlJb29Pbmhh?=
 =?utf-8?B?aCtTNkFaYWxIQ2VlUGpEZ2o3NlB5TDVEUGtWQVFmWCszbTBtYUMxQzlrTE9V?=
 =?utf-8?B?dmRpQTk4dDRhZXlMQllBV3dQTzl4VTdjN3FEam9qNTFidlRGbDQ2VFBta3F5?=
 =?utf-8?B?bHlGb2NmeTZwcTFoeC8zV1V5K0xtZzhMUk9xck1oVWQ4WmNFMkNpbHUzZTBa?=
 =?utf-8?B?MmJKeTJ5TXg4SGQvcFMzZnVxcWxncWxCU2pEQVRNUnJCU211U0NtZXByQkdk?=
 =?utf-8?B?Q3FEUVA3alF3dVFwZXBYaWozbHpFWnltWVRXUkZWc1Z6K01SdE1va05UaDlE?=
 =?utf-8?B?SHZkYlJldno0TXp6OUd2ajJUeFFITlVpdHNlRUppVVdCR3c0RFIvY0EyQStF?=
 =?utf-8?B?MWlpVCtldjcyNG9UUjIydlFxUlNaRHd4YVQ2aVl6cXZ2VTVqcldyeGU4cC9u?=
 =?utf-8?B?b3JkRjRLN081SG9uTElwbVJSSUdlRC9WcjdGQnNWOW5BUW9WMW8zVnZ1VlNY?=
 =?utf-8?B?emVabC84UWViNkpMaHdIMEFpQkZoaDlGNjdhaVM3cW1xQWtldWpGVXFrdnB6?=
 =?utf-8?B?Z2NnbkpuMmpGaytMNy84T01zQzJ1cThPQThmZGlwdFpOZVFDREExdGdUMWZ3?=
 =?utf-8?B?aVdhRjVNNW1DS20zQXpMaVVjbHBjQXMwQ0Q3WUlJa0FHZUlKS2FzQ1NqN1Zl?=
 =?utf-8?B?MDhxQXBoR0JtSXNmQjRrbllGNkpycDZZVmdnSUhhMi9rdm1PdnBFVjJ0dzhz?=
 =?utf-8?B?RWdUVTdITWVNMnFtTStSK3YwQ0lBYWdnZGs4L0FjcDhrVGJ3TWg5UHNibElk?=
 =?utf-8?B?eXdVZGxwWW9hSjF2QnA1YUlEWmpHeVZwTjlsT0l3VWFTREZQTkUzWmVpSUFC?=
 =?utf-8?B?eEtCR1M0VU9OWUpPdHorbDBZSnhlck04aUJpdGxFeE80Yjc2K1VSNDlNRWZO?=
 =?utf-8?B?RkNIeHRPQitTUlFzbVBha21oL2trQ0J3aFVpTEJ2c2k3TDBYM2tRWUpidlIy?=
 =?utf-8?B?cGVNejgzRy94MzIxVXVzTTYxYlpLb3R4Y2FvOGE5UkFzRnA2Q0FFeWR5U2sx?=
 =?utf-8?B?eUNvcGJHUzdQaWtiZmZpejBRYnZScWRQTS9vcnM3OHZMVjNBVVJUVDJnbWVR?=
 =?utf-8?B?cUZWelBleVNQclJQRkdkMm5DRFkxZEdoVm44VjhNY25QaFBwTzc0Z3djc1dh?=
 =?utf-8?B?T0VCT3kyUWwrenpvb2lrWmlXRm14cWlUR2xORkhoMVdNT2dPZlJYSDRxMmVs?=
 =?utf-8?B?SFlrOHMrQy81aUV3TXFGUThPeEx6TVJ4MmRIR2pOSFJkM2ZtUkJWTm9ac2RT?=
 =?utf-8?B?cVgwRmxNWVZXR0FMd0hjblV0dUxtRVpxNy9YaUgxOFdzMVAvSDc5Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 65652566-bdec-41ba-9e26-08df43e01b9c
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 12:49:52.6279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiKZL+NwaSJ54cNIbrCCHgEy8I7AVJGdFAFjJ5/REV/agGUixyfVT+AFPKV2DZQC3gOD9fvzq6/0DjBj07R7/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP265MB503956
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 16, 2026 at 12:43 PM GMT, Danilo Krummrich wrote:
> On Mon Nov 16, 2026 at 5:02 AM CET, Alexandre Courbot wrote:
>>> @@ -81,7 +78,7 @@ pub(crate) fn new(
>>>                      let mut level0 =3D CoherentBox::<'_, [u64]>::zeroe=
d_slice(
>>>                          dev,
>>>                          GSP_PAGE_SIZE / size_of::<u64>(),
>>> -                        GFP_KERNEL
>>> +                        GFP_KERNEL,
>>
>> Stray hunk? Maybe we can move it to patch 2 since it reformats that part
>> anyway.
>
> I noticed this before sending too, but for some odd reason rustfmt insist=
s on
> this with this change.
>
> When I noticed I was 'whatever', but now I got curious. It happens when
>
> 	level2 <- {
> 	    build_lvl(&data)
> 	        .map(|l2| SGTable::new(dev, l2, DataDirection::ToDevice, GFP_KER=
NEL))?
> 	},
> =09
> is changed to
>
> 	level2: {
> 	    let l2 =3D build_lvl(data)?;
> 	    SGTable::new(dev, l2, DataDirection::ToDevice, GFP_KERNEL)?
> 	},
> =09
When you remove all `<-` rustfmt starts formatting macros again because it =
sees
the macro invocation being a valid Rust expression.

I think you can also just remove the try_pin_init! here completely?

Best,
Gary

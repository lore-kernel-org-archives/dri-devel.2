Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B2DF53D79
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E412210E39F;
	Mon, 16 Mar 2026 17:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ciFhP4p8";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D7F89190;
 Mon, 16 Mar 2026 17:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtpPFBGVIY/h2K9BM5UUV5jBTVzrvYcQDpDtebmjrNJI9QW8oXaYraAA3iEaFOclenAc19I8S/dCARVqPJiFpCviNuhqnjaPPPCn7WPv3gzbXi9BVyMVGUkGyTSdzKSdbCF1JmaoPpF9Iy73cxvgmGEFYqJkFI4k1g0U7mDmFNUL94/9pQ36KXy2xyf84w7uryFVzX2kS+Nl13WSSa2KK+cqz8dGqI7zGf6dzq19tW5+bXi/5O2kGUQRj7FqCEuZyww5rGOK4aJPoCiJDMz8sbP0Lke9Ts79Pd/QBKLQmX/udVwJpoNGGVa2uvBstgRPboKJF5WdFY+joV7xlhQtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIhRmrisoxqoIEUxNgWbtQBTNgBGV7cyjWF2X6YX73U=;
 b=LwtPepAlw8ZY3D4YHlF9db0d7UgQYgMB27xqD4vUpGdrmzwlOn1wlAgq1GTyB871qm31NpnHHkiYSgrBA0gPZ/2CNT9lGJE/9+/E5Y5mfXgfbZNg7vO2RsssgHYcK4UCsDAOfW8aXQSM7JzWhfBETgKH/i+Lb+AtdIC1F39vXm8f4UW8YCU2kPAY4T98Rmobyh7JcIVVXlzZsfby8g3uC2BGP51YR9sK8wgSrFmner6dKsfaanRlrmseMX57NKsXJZjVHxRyGTEViR8woLYHcV1JyLIJTXAtLahcJusv5PCdvYn4gQgQMlpS7nsW1V21rIKs2yQh4NlFagnh4KheRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIhRmrisoxqoIEUxNgWbtQBTNgBGV7cyjWF2X6YX73U=;
 b=ciFhP4p8gPtSmOq8zME23UvFshVpwsJefzw5LRcVfQ5L5BcHuMh5Fodr1jSAqkJqFxHy9+jc+mj3fYCntZyzuDC8V4jkz5RUqGZfmC0rFgNOpwLTe5IMP6x2oc1kJze+54OIkMe4fvCgyVMFBUUrpp5U3/OuKywUO7FccMwdokw5PxmMGTC4q3Kn5kOZfnpJCwrmrincVB3veggrwWjGxmLB2Iloq7wQ3AHL2SEvAr82GRZ5OcUeMauKrkAtLap45w5sf6Bb6XpTzN77UAeAj23MmLNYsCTXFGoC1QTWUhdmM/2ROgGzFacxb3Zswgl1pL0mbxDOspNRi2QNp+Vqww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 17:00:59 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 17:00:58 +0000
Message-ID: <6b4e7327-08a7-41db-966c-48faed3f33f0@nvidia.com>
Date: Mon, 16 Mar 2026 13:00:56 -0400
User-Agent: Mozilla Thunderbird
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v9 05/23] gpu: nova-core: gsp: Expose total physical VRAM
 end from FB region info
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Nikola Djukic <ndjukic@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org
References: <20260311004008.2208806-1-joelagnelf@nvidia.com>
 <20260311004008.2208806-6-joelagnelf@nvidia.com>
 <DH48J45RRVJC.15YBFZ05IGIWB@nvidia.com>
Content-Language: en-US
In-Reply-To: <DH48J45RRVJC.15YBFZ05IGIWB@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20)
 To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: e011e098-43b9-4ab0-f010-08de837d984c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: q0wQ7K/w+Tl5E8SryqRDEGMT0KHOs3rhLjfYHJx/OY0m6j/cMDt40rrKRhBX6SNlY1G9HcKkFEwiptGlmAs+T6AJkEIqFTqEEPFP6QuyBtMGaMadu4rl0NHWRDMdAHLRahZOCSnfA3YeRa4o26tU7gCz8aegHU0p9wL37fqy4vxf0etlHERaYfRoIvVUc/5Yabwudium835ogYal7TNAjc1nF/SdYTBcLskB3R/i8jBlUAxLwKbxr1SkvpoLfUqZ82A8DaI7VS9aJLK/bnVmkWEsaGz34WJvEf31edR172R4oyhobw50/NHGZ6TSsX1a17w592kd4JyhHDEUceU7jYVbb/tTEojJuj9SOdCiAM3l2OgkwUV/lllH8aSFXOrOkbPBrNr7frp0WGuUwRBR97N64pgJ/gemjIQyd2SyAmIAZre5NAslVwF6FwyhVogaiTuol7bBfzDZ9fLlYGzc3vf9QYEr52MK8IWat0yZFm4cGn2hRmkstPDwsOtTfcPAckhbqsYsMGQyRsOg20NID9HiB0mvMwGrk/iLJP6IhyllO03cHqi5VMKGyo8PY/IWLh1EckrAxIoSzS1DRhAgEEkIQMUjSB9JYkyXQIk459KrvTF3KTiiK5JJdAWFTn/4p7LVxnXA4E6ECa/bl+blYEp6HkuPG7lPgu7WfUdwi06fypVmcob/q/jddlfXvN+X18Syu/cqlrQc+5nWsuZ8naYyo/F3BF8bayKCm2u7+QU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEhBalk4RFY0THNUd1hSVXM3dmltMTFuNEI5WWEvUCtiSnp2dEhVV2lpdXBW?=
 =?utf-8?B?RzVOZkRxZEJSc05SWW1CVGVuNUY2M3pBbkFTZ3JvM0c0T1JtSFdKZHk4cDcz?=
 =?utf-8?B?ckg3WE1zTzdxalJ2M2ZvUTdJc2JxR2I3dEo5VURHRHdXTC90aUsrdEl4OU9s?=
 =?utf-8?B?RkhnNWpFRklrOEgrNmxhOVI3ZkhkQU9IcVlUbDFCQ0tOSVNBUjQ5S3ZIczZq?=
 =?utf-8?B?YnhGT3pLeUNReTdYTG9TcmRydnNoV2FoNm1KYUFJSVY4dlFrdXZ3Tm93S3pl?=
 =?utf-8?B?aFNnOXAzUkoyS0trSjBVZkh4MkhEbmc3ci9KNHNHbzRjMDBoaWJaaGVXU1dB?=
 =?utf-8?B?ZHMxK0JTbVhmL2JMRDh0ckpnVlU1OTNtU3hEaHQ0OC9XMWY0ZU5laEJoalk5?=
 =?utf-8?B?ZUVZeFc2S2J3VWcrRm9Jd3NZQlpNaEFoZXRUY0IxYTdtQ3d4TDBwSWRRcC8z?=
 =?utf-8?B?NnZWS3dQVmxoT1F5QUJvU2NZZXNRUnVDc0p5cXM3WG5JeEoxVnc1VS9RWXVU?=
 =?utf-8?B?SlBJSHExT2pWV1pYRVZBQ3JnN2JmMGZVak9vdzZkdzN3dFp3eUFyeUtqUXNW?=
 =?utf-8?B?OGJacHZzdi8vSE4vNEI2NXZHK2JrKytrYzJxR3ZSUDNYaDF3RVBVK1NuaWZk?=
 =?utf-8?B?bnNCdGNWbHlaVmJpc0p2YW1WVzdwdlc0a3pvcFV4WWY1SFZPNkRtbWh2ZTFG?=
 =?utf-8?B?WHBkdEw5RTgxTHBKTGZnUTJXeFJ1ZlpKZW9XR09tVU93WU1YYmFVVzN1SG1F?=
 =?utf-8?B?Q3dnVDhjYkhUQ0o5TWtyRlFlYTRIZ2dpejYxS1pCMm9Vc3VENXhlSmRQSjha?=
 =?utf-8?B?cTdmRU1nbEJBaWNsVVlHSTZvRW5KcHorUkcyZzJGZUpmZm1FU1pFSzlQd3c3?=
 =?utf-8?B?bkJGMHE1ci8zaE9GbWhuUFQrRTArOUpyeTFkdlNDR1ZnNldDOGN6MU1KRnk0?=
 =?utf-8?B?aTZwYVQ4Um9BcnVRcm56ZW5hY2ZtbVVwdm1jUEx5WC9CNnZwY0J5b3VTZmtj?=
 =?utf-8?B?YXQ4K0M0OTZZWEkxam1wckRFdzRpMjd5YWV2cjFDZEoxRVFGZlNwa0tEcEdi?=
 =?utf-8?B?TFhCSW1SN2pDdDlselgza1dCWEwxbXUxT0t2NXErb2VPbmt4OUJuQXFIOGhJ?=
 =?utf-8?B?YS9XZ2ZURHllMVo4MWhKckl5MExnTzlhbllTWkN0bEp5ZENwUlZGa1RYV2lW?=
 =?utf-8?B?eTd5QW9XYnJQUHY4SFF0L0ttNXM3MzhSUURSaHBkaGkwNWN6Y3phdFdNNVNG?=
 =?utf-8?B?WHl1Y3pjbFRWNDZ6enlIUEdPODVMTytKRHE5UWwxRDVMcWhLamVOenpPSUtR?=
 =?utf-8?B?TmJRL3psaWRmUUNkTThKajBLWklxMTBYYlRnMndWNExiZENoN05vN21oMFJB?=
 =?utf-8?B?SkxFTTN6V2ZlaXAyRzdValkrRjlaTFZMTDJuUkQ1bDNZUlQ2eENrMFFjZzRR?=
 =?utf-8?B?UCtLbWFlOElFa3VBZW55NUVkMHhOS3BUTFBDdmd3NnFNNXVWRk94S0xWcHQ2?=
 =?utf-8?B?NnlCZGNXVk1CemFmVWZvd280eWxrMGVEdE1RaEtxbklhaXFnZXRlVUxxN016?=
 =?utf-8?B?blR6RWduWFg4bHY1QVYzVnoyaVV5dWFmZm5yYXcyaUh4eTNUUTk0OXFNL1c4?=
 =?utf-8?B?djZLQTFnU3c5Y3M0S0huYkxFUi9maVpCU2EzV0VxOG85SXlkMU9QOXdpL2lv?=
 =?utf-8?B?ekljTURhZXRLZjZTVTZhZm1uYU0ydmlsNGlIVmkxR2M2TzVjWXFSZTJIdVZJ?=
 =?utf-8?B?K0l3ZEpGaGwxbkExQWxBeE5pTXBNMDlmQXRVSzltNkFpNG8wcEJySFRpcDNL?=
 =?utf-8?B?UzZlcHRaRWlJKy8yMW95dkVJQitaMTNhWTVkakxRUHZKMnI2bC9NMUh0eHor?=
 =?utf-8?B?MnVoUEh1dWhCaHp4d2xSUk53OG5iNjdmd1k2djJqT2JUL04yWmVBYUZVRWw5?=
 =?utf-8?B?cjFUa2JSemZGeWZaR3A5VUFZbkdVenRVSlVnd3UwSEJmaUZHZ0xHRVVoMGFx?=
 =?utf-8?B?YW9uTGIzZmVIdmJaeTdnL2ZwSHZmWHBaWitUbU5pNVgrdXh5UTQ2c29wSDlo?=
 =?utf-8?B?OG5EeGc5L1grbSthNnZqeDRxcHhLaFdaVmpnMjk3aUhicmpKcjVKSlkvK1hG?=
 =?utf-8?B?aHdxZzJENEM5czU0ekVZeXhTT3BVVkFIa0VHOU9wMmJTWU5DZXh2ME9vYzFH?=
 =?utf-8?B?bVkwdHVsdDhiRGFSYWdyeE1NbWRPSmdBOHVjUll3RGg1K0tiZEdNbVB2cnRx?=
 =?utf-8?B?aGtacGNBYkNTVWpDcVBIVUJkV085ck0wcEt2a3oxSHdCSWs2d25QY0hTKytl?=
 =?utf-8?B?OGpxQXJPQUdLcmFDeStZOWRwSFljd2JsL1YzKzRoRXpmTzVJRGdWUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e011e098-43b9-4ab0-f010-08de837d984c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:00:58.4992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suZu92DTRHyAliftemjWhdlkZm8QsWVgol5gxpajKZGe79aH/rkDeODjpRHjbprBPRI8r3s4bwaKwfGLPhiceA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
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

On Mon, 16 Mar 2026, Alexandre Courbot wrote:
> This is basically a repeat of the code of the previous patch. Let's
> implement an iterator over the FB memory regions (that filters out
> invalid regions) that we can leverage in both places so we don't need
> to repeat ourselves.

Good catch. Added `fb_regions()` to create an iterator which both this and
previous patch use. Nice simplification:

    /// Compute the end of physical VRAM from all FB regions.
    pub(crate) fn total_fb_end(&self) -> Option<u64> {
        self.fb_regions().map(|reg| reg.limit.saturating_add(1)).max()
    }

--
Joel Fernandes

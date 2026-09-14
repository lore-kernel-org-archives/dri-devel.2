Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4DBC88E67
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C1110EB80;
	Mon, 14 Sep 2026 05:42:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GJamQJTH";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F9D910EB75;
 Mon, 14 Sep 2026 05:42:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gsb6yCBSyb2n9pQ0vJmYv1tqNGkPdJHEvMwgA4jdw8692ybIFNoD4NENgEtRwDPvSzAvTW+YbMerlnKWQCwppplXyh6s+nHtZt/UcoFTGJKLzJdg4X9DmlB0mNKL9m7cg53FWKBDeO9NkrxaxlFSCC2wf92cDqWIT396+ZNBixii75Ef5CBOT6J7E5bonX4PQERv2crDiP2uZBOjz6kaVy/y0t+ldK9xEKGcP+eGn50JdKM9SCdE9J3XswCzR6k7G1Hk7QNelHKnzgEjkFCbgQCKTXAYCe6v9dqFBFzswEMt1FTXjcjzwbEZAtuBzVW9VIcggY4NrXfHbjF06ONimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhzHeWTYMh+bynsSO3wKczSSJFGN/srIn4jTlhOsLN4=;
 b=AUO4m4nINn0wH/u0zoTVThDNE1sfRvh95IauVjaG0Lgva3coJzX7HI1lsz0DQY4Yrh82amFBt1qZ7p+0F83wIhzEYVqDovkHSHRH/AHh/ODr4XmFlbJ+qm6iAVyO5sBzrfF1lSOS7lservHhOsuTWthcur3PBTqQmX5TJUBo3qIp3ITdAzHBlPKxB8h4LdTAlUjsCJL9j4qYTwcrCsGc7DVs4cRZZErQSSfAcgt8B/4J5FZfC1kMJGBvhY5q1AbhXWgOoN4IWgMcpJV5RGa7sZh6c7K9rWlCqA8tHdVBbKpBj9mpPDYHVXxXIIxNSA2tJa4uq7r8FkIYGskC1+HUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhzHeWTYMh+bynsSO3wKczSSJFGN/srIn4jTlhOsLN4=;
 b=GJamQJTHaySU5FWY7xamj2HaEXwQ29JlntVZBGQyRdFVUyCasQJS4yqEu3KXWnunvTIhvuO/T+XWN/nbzI8iqLggGKN+BsZBeTxuuSMMkq6OiuCd09yXsI+ET4KWG7tiidEQRLQO600Nt6/IqJTAVbO/FOquCq12bQtNbj7+qGtlN/IRxlju9VebHOT2Zbu9v77IkJZlQLvBpxvsDJp+MRCjuq5cdjoJAe4RNXLCcQ/JDJwpthxy6MZAkvnAUqGz08fW91WW8NRULPhySsQNEcrXqik+zTB1CVFddY0umpECqgyJIspB+WQ2IXW9IUem8sT6A/HB7aJf+izYDBm+1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Mon, 14 Sep
 2026 05:42:18 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 05:42:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 14:42:14 +0900
Message-Id: <DLESSF3W6AV9.3GZGHANXDQJVM@nvidia.com>
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
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 8/8] gpu: nova-core: add NVKV GSP_INIT schemas
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-8-0de9d5c8658c@nvidia.com>
 <DLEQV27IDBCH.16D7K7DXI5ZK8@nvidia.com>
In-Reply-To: <DLEQV27IDBCH.16D7K7DXI5ZK8@nvidia.com>
X-ClientProxiedBy: TYCP286CA0144.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::8) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 877d7ad8-d30b-41a6-dcba-08df1222f015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|10070799003|3023799007|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: f+RuU0lHposLXcfDKTHWn1MvPAw6/49YtWhX2mPfsa9+L2ATcCj4fINaraZllOvDklhFpX8+5sTtHe9wkGI/lOonZEEePFz8yJX/1upT6F7+co5t15IjX8yplXTJDncYc40JWAZgbDgUJBMl7ej+AFTnL82f9j8u9kEBLVLcTK6qDZ3r7HzV4sjBN2qu9I5KNqM0NR4jkSMegxKTjzrLg+6WUn4Fbsie4mw3YepugP4ce1s5DF62Dq2F1TxujFAx826/XQUNE+TpaxVz+ClP1hjQmkeVVx1ojXxi9joixvPrcc44EU8LSsI296P8xt02x38TzhoBHxihkyt+1APAvyqpChPOSBmWdwh+zzdsBgn24FwarYBpv5BEnnYFoYiYfrR3CCLvttygkJUWhals0E59e9KAlJ8o8QSjvs3NRIBqxqqG2RikyYEvQ9oFLBtg+m+IUJknLVKkepWjULFOUQGde2pIwJNOBOkbRi+HvXvgwjLniQhU54RytiuH0Z1FI/aDHnRQZ46E7IzCRkPP4IoKvWocziOfOulzwgWMiNBSjmEV8fu1qgA56rTnyIPyTyPId7WCVqLt/RBNoWjAbGBoOI/WmugJ42EMneNwborfSj3eVvuo/6OwUpE9Y8bnY3pvMKs4KCrvY333yOxDEBTdaVGBL/XPvAPwhSDA5HU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10070799003)(3023799007)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUQ4L3VsVlNURUtTTGgwYkdMS0diNDFmSEk0T2NabXBCK0NUZGFpcml5dzlL?=
 =?utf-8?B?MmVZMlJqaGZaREFzUERtaDJtVXhoeHo4WmwvcUdNVVJ4UmZuYmx2QVhYSk54?=
 =?utf-8?B?azVKN3pha0lyOGxDVUJrOVUyVDFGeHY4Z3dOSEhUd0IrWnhRWU8rQ2cwc0tv?=
 =?utf-8?B?TG9FbUkzbjJCTXM0VmUyZ1VnQjN6aForaXRYK05VNGtjWUVvV010TjJKWU5M?=
 =?utf-8?B?K2Q1L3F1ZW1GakZEZDVQTzNZT0x2ZTVLek5zYUw2bEppYTFLYlZYSnJTUVls?=
 =?utf-8?B?Z2dlY3RZdlZ1S253dW5XSkMwdVp1eHUzUkZLdUtBRDVCd01JaHhlcGk2ZE5D?=
 =?utf-8?B?VzBzTWJEemkwZGxzU2dzeFJidVVyL1ZUU0tuQ1BEUHpJUEM4R1lhUmpKdVdz?=
 =?utf-8?B?VW9UcXFiSU1sRGcyNzV2bmdTQjl1bVRGYWpQM05jRlVNOW11R3d4NDgxa2lC?=
 =?utf-8?B?eG1pc2RDNU9sVmFocGxzQ2Z0OVg2YUo0NmxQdVpVWUEyeHI1NUZGaWtiS21z?=
 =?utf-8?B?UGNJS0xkMEw2dnRwT0hRb1diWHgxbDM2by9VQnlmU3k0YmdESW91Y2s2Uzk2?=
 =?utf-8?B?d2R5TVI0SGYvbUQ0a3BVeVNnVkpMVmI4VHJJajRCNlJ4WUhXdTdickxwZEZ1?=
 =?utf-8?B?Y3lUWkhkWkZuTkZXcktYUUVPN0tZYXVOK05CSDNNV1NMSW40MXIzcElzK1FR?=
 =?utf-8?B?TjdINUVZSkN1M05PdjZMN1JOYUVkRTZPVExtblZHYTB6aW0wMlNJQkREOUxE?=
 =?utf-8?B?VUozRmFMS3RWMmcvd1lsWVh3bzdFYWhGMURLMHVISFJKbVVEV0FjdkhGOHpx?=
 =?utf-8?B?NURHMFViYVcxd2JlYnpPd1FCclBpZUZBWGFYbVdrYzJoYUVHeWhsMmtHVnBo?=
 =?utf-8?B?Z1YzRUZpdVFYVHh2ZGEzcjlpQTZlOUV0dEJmQUNneTNNVGdQdyt4bFpRYXhD?=
 =?utf-8?B?M0s3NFF1NmpkcjJhL1M2RnJWWktlM2RQWVRKTWExWjlOd1JPa2t5Znhnb1Vo?=
 =?utf-8?B?Y2JEKytZVDdidUZzaG1TV0p0cGllcjJ0bUlQT2ZQV2k0dmtwRi9EME9LLzNa?=
 =?utf-8?B?RHFhTUxxL2ZNa28wR2I1b2RoZmRTNXFjeGxzY3haZVpqaDRnSEtIcS9LeDlj?=
 =?utf-8?B?eGdBODBKb01xSjE3SlNydTZtSmVBWnVmVERuRmJzVngrcHkvNGlMT1JqanMy?=
 =?utf-8?B?MHhwdFRMK2FJR2dhckJxOEwwMDZsTWtYNHlEM1NFV0RjM1c0UmxxWm52Nkpu?=
 =?utf-8?B?djdMbDdJaENRMXhyKytBSlZMa0FFNkFoYnBwQ2VDT0lIVHZ2VFVQcHFiTnY0?=
 =?utf-8?B?L2g1bVNHbDVtbXVvVUdTUVp2VE9ncFdsVTFoL3E1MzhPSW9JUW9RVVNZNEN3?=
 =?utf-8?B?L0VEUnpLYjdEeE8rNm45S0phQ2YwYjBKZHl6ZUN6QktFVDV2UGoxdEZYT2Zu?=
 =?utf-8?B?TGFxbHY2QkhtZkVmbExEZm5XRnlyUjFDU2Z6T0RoZFFSTVdBYVQ4cWwvS25B?=
 =?utf-8?B?Q3RIaElrbzZFaVAxSm9jVlgyeWFGNFNmT3h1ZkxUTSt0K1ZTUHpCWDQ5UjY4?=
 =?utf-8?B?MnMyeEMvNGtvcTArMkdyc3d2RmZWMlRPcWQvRDFwUmxQNmNQOWdqM3ljSzdj?=
 =?utf-8?B?U0hFSGhDSGJQdXN3dWMrcDIvbVZ1M1pEdjhFMytMYkp5aFVBamZZT010THV5?=
 =?utf-8?B?cHhRVU9qeC94dy9YM3VvaW1wYWRFL1E0OFVsdlMvOHNqUS91em5HWGZxMGNh?=
 =?utf-8?B?ell0T29BcnNxREd1a2pyblhnbUsxK0FseDMyVzA2Tk9Ga1dka1ZxL1RKSFFZ?=
 =?utf-8?B?V0VQdkh0bkkrNEhmK1F0aG9ITjNXeHp0RDhCdXdrTTJJOEdDWUQ1bnhiS05u?=
 =?utf-8?B?bnNVTS9JV1ZIZlorN0FZZ01TNkY5TXhiZHduTGdaQ1FIRitpZUR3VTFZSlF3?=
 =?utf-8?B?T1VLbzAzN1BqbWp5L3d2Yi83aWtrUDlqQmdHTXFURHJId3M1Rml0VkFZMjky?=
 =?utf-8?B?dHNsMnMvYzJWdCtEdTh1S0xPVlpzSzR5anVOd1VEL0JHMlBuNGlMRDFodEJF?=
 =?utf-8?B?bVR3YkNDb1hTLy9DN2d2OXRNT3l6Zm51SzlyVlV1Q3JuUXdMZlZDNXJMOHBC?=
 =?utf-8?B?dEYxY1hNcWQ0eTBpOHlEVXcvQWNVNHU1VFJJekR6SjBnd244Yy8ycDFTdG54?=
 =?utf-8?B?M1p4czdrd210N1d2TUFYVFU0RjV0NGhXalhVb2lITUp0d0NodWFGYWl5N0VN?=
 =?utf-8?B?YituSi95R2xTMVNHQlY4WWtFUGFXNEhES0x2ZlNMejlFNzM3UlNLODlybHVh?=
 =?utf-8?B?SlJtTXhwdmQ4QTBMTjBiR1R1Rll0U0FhcUI1ckNZT2FROUJOWVZzcCtyUE1P?=
 =?utf-8?Q?qd9fKP14YNCoz+iRW+OhoTDN4kieZ1+eXkQi6EydLpVSI?=
X-MS-Exchange-AntiSpam-MessageData-1: JV6nndtq4yjrWQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877d7ad8-d30b-41a6-dcba-08df1222f015
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 05:42:17.8112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dstTJbHx7gYfimzagujLzmDWVTIRFhQSVdp8caFIpV8eVXWQ8/CdKpVVO0Wct8f8hbCL7/lQ3gL5mYwd6e4rvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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

On Mon Sep 14, 2026 at 1:11 PM JST, Alexandre Courbot wrote:
> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
> <...>
>> +impl RegKey {
>> +    // Define the Key IDs read/written by GSP.
>> +    const REGKEY_NAME_KEY: KeyId =3D 0x3070;
>> +    const REGKEY_VALUE_U32_KEY: KeyId =3D 0x3071;
>> +}
>> +
>> +impl Encodable for KVVec<RegKey> {
>> +    fn encode(&self, encoder: &mut Encoder) -> Result {
>> +        for regkey in self {
>> +            regkey.encode(encoder)?;
>> +        }
>> +        Ok(())
>
> Maybe this is just me misunderstanding, but how are the keys
> sequentially sent here? Because I don't see any mention of an index, and
> `Key::encode` hardcodes `Index::new::<0>()`, so how are these supposed
> to be decoded into an array? The `gsp_init_request` test below only adds
> one key to its `regkeys`, can we add at least another one to see what
> happens and verify that the received content decodes as expected on top
> of checking its length?

You are not misunderstanding, it's just a bit odd. This is because
sequential regkeys are all sent using an index of 0, according to the
protocol. I can add a second regkey into the test to demonstrate this.
We currently don't and won't soon have a need to decode this kind of
repeated index 0 encoding scheme. We have `Accumualted` now, but that
relies on the index changing to know when the previous value has been
completely sent.

To test that the content decodes we'd need to add either a test only
Schema for it, or add a schema that isn't (and won't be soon be) used.
Alternatively, we can test against the encoded byte content directly.
Which do you prefer?

> Also drive-by design question: do we expect to have bidirectional types,
> i.e. types that need to go through `nvkv_encode` and `nvkv_decode`?
> Because I guess there would be some mechanical overlap in the
> definitions for that case. Although maybe we can mitigate that with
> another macro. :)

So far no, but I think it's conceivable in the future. I think in that
case we could call both nvkv_decode! and nvkv_encode!, with decode!'s
schema mapping to the encode!'s struct. You need to specify three
things: 1. how it's decoded, 2. how it's encoded, 3. how it's stored.
This current design, for encoding, puts #2 and #3 in the same place. For
decoding, #1 and #3 are separated (since Schemas may need extra state).
For doing both, I think we can avoid having two instances of #3 for both
encode and decode by using the encode #3 representation for what the
Schema decodes to.

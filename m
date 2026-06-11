Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5203FCD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E4710EE75;
	Thu, 11 Jun 2026 11:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JGkUaj/3";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011056.outbound.protection.outlook.com
 [40.93.194.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5242010EE75
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 11:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZJVn+pmw16EvYzG8mqezgI8lpD6/L83BKgxRF+FVajqzppPnHWpxv510dNH1Ce+C0zlMsFxhxouLU1O0ov2VJvvaJAOBq6P9WKZ0xQ0dgIkZkWL1qZVJ/h9mxD60bPHlUAYqL0pb5eLb3BCWxRCS3vEnTYgajrKrgHix5iWh5WdR0y3985fIMKdEvzsMj69+LpMEUg88gv8C4PUtc6sITokQiqCnut1pYU9VDnrv7LCnvSl5DHtf3CAdi/Kb2xt/yAOaRd5ai11aTMXNP4wB5lJwM82mWhTnlpQ4eXHciYuwHsAWmcp/A8pmeultJ4FuQ5Uthw+o+2pciqm9UQ82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=posVp4UvRj1iW5DSaSdHNoPqB50OOUFI5EmXhEtpTMc=;
 b=EVgJUzq0++fMzuQEU88TOPF7l9dLvyZi1GXxXDsGJhUD8gF0wdFq5FgSTy05rsszHPzTubwMGJqRiYIOfzb/uK9FQipc5Zh15EeL7nbHULSsZHxs86/cbDcXblEM6+PNo/wQjZc8S43EahX7PnrQ4Cz7W6lIGDQjsYYXAeCYNAbEmxMNY5R8V8hVNGxMcmllnf+4+GMYaYDJMKuzJHHONBB0iJmBqHo7FJjb4N+GbQXcRHB9DAijCqtDCQb2sj2aoRF694dx+/di+g30wlGjD8H08USR2CwFmAmUGBPvZLlQGX88zM39/Gmt/pL+zxEM27reVlVsUmDFX1yXniSVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=posVp4UvRj1iW5DSaSdHNoPqB50OOUFI5EmXhEtpTMc=;
 b=JGkUaj/3L8d0kIxCHbAgFx9+OfkTuq4e4496y2pZIC9FNa9exL3UQhhki9qhZYzVpxTg/C4z1SQc6DLFct+w3tUXeQ4YaSMwLWq8gFnfLK3jx5dgV2KNOkefkwq7/qjOX+uSVkt6tFNIpuOmd7hR15AmRFnqqwBgn1XQgGW7bBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::629) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 11:07:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 11:07:03 +0000
Message-ID: <8701d825-eaca-4f3d-bd87-8c2c53e43d2c@amd.com>
Date: Thu, 11 Jun 2026 13:06:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
To: phasta@kernel.org, Danilo Krummrich <dakr@kernel.org>, airlied@gmail.com
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <dwlsalmeida@gmail.com>,
 Gary Guo <gary@garyguo.net>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260608142436.265820-2-phasta@kernel.org>
 <95f4ae6b-9dec-4122-84e0-fbb0cdee9cb5@amd.com>
 <fa9a335196525adbc03ec21b2e05bb526e4fc174.camel@mailbox.org>
 <9d49c901-fcdf-487a-a733-0320d0bdf94c@amd.com>
 <DJ3V3OCLIK2K.3CYKWYNHYU6JQ@kernel.org>
 <ea4e0541-3702-4014-b8f6-0746a148df86@amd.com>
 <DJ3VYD71HDQ2.3C8GG983Z2YCM@kernel.org>
 <c8564ea0-8ff4-4049-996d-bd978c478372@amd.com>
 <aebe759117cd65004510946e39bd02e4c903e1e3.camel@mailbox.org>
 <84519e72-e057-45f9-8ace-baf12f095e55@amd.com>
 <29754897c2b6d0a9560a05fcd1c0a0946577518d.camel@mailbox.org>
 <25494ee8-5108-4044-b4d9-cfcb37c397ea@amd.com>
 <c6a3964b130ac371e203aeee5f5b52d146c22bea.camel@mailbox.org>
 <c3e8a9b8-e344-491f-8b8c-f6a682f15121@amd.com>
 <7dc7920604169a8d7ff97c70bb3867286f3b3ea3.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7dc7920604169a8d7ff97c70bb3867286f3b3ea3.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: bea367c7-c5c7-4714-714d-08dec7a990e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|11063799006|5023799004|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Za8JpNb5OjE6UcNokEreemFBYjWxLNiCzN3DAtY4MxVWhmtcXzq+DMVFzE50bJIMflzofp1KaLIPrltyZMWGJDWoiGeAFILC8ROKm8Dx2k6Rrfi48QPH8ffKrzDqRUzeoyL45K7a+DkG8hRyHof78j6Wjz3ryaoXzSpDWHzIF+22MKmX+kGSZZkglUHH4pXWYuvFPyGTCaVD23S/wr/GcS1aw8ojj7DxGrvjFtq0Ju6Xm0AwkFyJVeNuK2PJqzKsO5VH1qk/bLKF+WO+0FDasCnqbQ0IZKuDwnxDCoKAzp3MdxXhMJ8ncQ9el2q5O+q0ct9gw4dM4PpDKajG3frTEjGIY7TS8np2ZxSOkT0q/4i61tqlql/+tlM9anbx3SZLpSevOfPQyTjwLiQ0+onHsMdaq1fbKP08UjHycJj30nGgpu/4Uv5x3HgZwPc0+bcDW7K8vQ2bkvh/wTM+NnTwQKw3JLS+s5A3O48V4s7rS0xgOHNGctqKcoyAvC//Q1RfHG27GbzSlpZKaC+Wnv7bEVAwvQS3woa7qkrXVKI0Tfo0JNovtwLmpBprjNwKA0djUzaJXEnEou0iSz/s3x0qR4Pub60oI0QLlEUAbzZH0JzuEYuCdsf/O5MhrB5J9jXRTr1pyQ4wk5lYW1kfSTQRKVs3XKr6CLOkSApgPgLdWTKk9eCM4e3r9ibvhrZp5ML1yuBYFO2fUfqJuRUsnGDI4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(11063799006)(5023799004)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk4zN0J1S3A1Mk8raTAvcDZUcTYzS2J6T0thd05VSWkyaVRkMjAwSVJQVzJZ?=
 =?utf-8?B?cXc5SHVvMkVzMlNEa2VzRlVtQ0hyaU15VnZCT3JLdVRyR0NIaWgrR2pEYU95?=
 =?utf-8?B?NUdUdk1lVE1zTnJ0TnVQZ0wzaithNUhBRTE0Qm5QOFUzSGlYdWZwNEZDRzNr?=
 =?utf-8?B?SU5aZC9NQkhTMDZ1LzZLWDlseHJUUVUrOFJTZWZBYmc0eXFwYkRwTWpkMERI?=
 =?utf-8?B?MktJK2xuZnZBejM1T1VLdTBqZ3drUi96QzVBM2xwckRhSFBXeEJweXNyUmZR?=
 =?utf-8?B?UVRWazJYVkZyVDNhaXJuTGtKN2htcGtIQ0hNMjJrR2I0ak9GaHNZWVBCRUs1?=
 =?utf-8?B?TXB4N0Q3eGpVTFlsQzMzKy92empvSFdxeU1pVW90bmZZaEV6ZlZaYVlYR0oz?=
 =?utf-8?B?WTZhVG96Si9VcnVEUTdDcno2TmpsOHY5NVowZ1JreW9yMXBIVlF4bHdiZUE0?=
 =?utf-8?B?UHAvaGVaYThhaWE1dEFVdHAwY3JOaGdPd29WL2FVbTJKdC9CZXdlSGJ0ODRU?=
 =?utf-8?B?RVhJWTZmTFdWaUE3cE14QkFKZnh6c2hoYTc1Ry9XY1lXVmx5VXZkcmdBNVE5?=
 =?utf-8?B?YTRMRWpGRzFZeDl0NlEyenhUTUFXNE5MMnQvQmlrWkJlN2NZaThFNGZCb0hw?=
 =?utf-8?B?czYyaDhXUk8zTnF6ZSt5TTlnc1ErRnVxdDBZME44M2F0YmdwTTdzK003emFu?=
 =?utf-8?B?dlN3Wi84VWZ0ZDV5QVhsV244SWtwL1gyclloc0JGSmhHZGlIRVp6REkxTFBR?=
 =?utf-8?B?MXNySUtoeDZnYVVQbncra0Vlc2Q0am43WjJsNnNnWTV3bjdEU1lxdlBSYjFL?=
 =?utf-8?B?ZTRpZE8rS3hyL1Nkc0xqK3BNMXZzQlBkTERObUo1cThzUGJpTmk5QkRlRWFz?=
 =?utf-8?B?SVpsNlc0RDg3NzZZWUt5RksxWTZ3RGdLb3BRUldhU2F1eFhMb2xZUGpBcldx?=
 =?utf-8?B?TnZuVnRLU2xIRmp1dFcxWFduUkdxTjhYV0RvNTV6ZENmc1hWdHpjWVBya09J?=
 =?utf-8?B?Z2djcThac2Q4YmpNOUdjc2ZhZ1d3T1pCcjVYYmFqNUNYUTZjbnYrTWFTejJi?=
 =?utf-8?B?REFna3lNM1hJbGdnQmpLUnJuVTQ1dDVudElhWjNsUWxvc1JjbUVoa0pveTZC?=
 =?utf-8?B?R2dMS0FVNk9ZV1VZNXl5VlN5c0NaNExJbnhiL0FVWnN6ZUluN0lqem10dng0?=
 =?utf-8?B?emFwSFJhT0p0b0thWGRkVjFjblVnMFV2MHE5aGdKbmVHTVdMUlFTZ3dhdm91?=
 =?utf-8?B?WlVJeUlKQnBCQjZYT3l5Z0crakNGYmo5dzBhaytMNFREVTc1eHpJL2ljTXdP?=
 =?utf-8?B?SmlhNGRoOHErbzh6SmhVclZWWWx2aXN6ckpjeHZnWHk2a3BqWEVTQnpZK3Nl?=
 =?utf-8?B?ajZncS9tQkVHRUFBNHFrYWszUlRHUjlxNGlidmwwTk5sb3BVMktidktua2g1?=
 =?utf-8?B?cGE1dUhOSkdVRkpxOUx1NlhPMVRkbXU4ZnBjT2ptZmtvL3lQTDZ6YnJPMWtK?=
 =?utf-8?B?NUh5dmd2ejQ1Y3k0alh3aUtvQ1FzZkRUYU9Qdy83a2ZHUGVKazZWYkZyL0hE?=
 =?utf-8?B?bWh3bWJia3ZvMUkybUZtNUtVZmg3bnBiSkNhanl0aDZOcmphdXErSFhTZ1Vu?=
 =?utf-8?B?U241d2l1SjRLTXlTTmdmNWRLc3JnbUFjeGUwSmtJNDFjN2Nxb3VuQm45NHpw?=
 =?utf-8?B?Y3QvRTlHWGVHVE9KZ2dsOTFwMFB0WHVzZVVCTlZHQ09jNVpldEZNVFpBK1dU?=
 =?utf-8?B?TmlkdmNBZjg2bkFGQUFVSnhhYTFTbENHeFBqVVoyZmUyT3hUS3A2OHpiaUV0?=
 =?utf-8?B?bmJJWXRZRmh4dnJ5T0tHK04wNFJHaGVDeWF1MDR4OFU3UUtKZGFmdWN5TFVl?=
 =?utf-8?B?Q0hBeG1tYzlYMVhGL0dBVklvaVRLdUl5bTRyR3J5UzZwbU1VMXVBSjVyTFMv?=
 =?utf-8?B?V1RNOGlvRjJzcHJrVWtXWCtqdEhGZHJSRXZYejRlTm45RFhkOCtEb2YvRnpN?=
 =?utf-8?B?Q2ZNaVpFZC9YekJWeXJWYmhZYmdRMzlHcWt4VTJkL1Z0eWYyaUFpc0RFdkJO?=
 =?utf-8?B?cnVVam1jeUZvQ1lteXZRWDRtU29mYXlZY3J5L0Z5d3k4WXpHN3o4K1pwNWRw?=
 =?utf-8?B?b3l0RGlhVytPVnBoQmw1K3RYWkE2Q3dscktBa2V4eEx6OEc3RjVYZXpwT25m?=
 =?utf-8?B?ZHhZVnprUURyUDB1dGd3U0hYR1pFaG5iV1JuZHJLUHVGcjZnWGZ1aUVVZzJI?=
 =?utf-8?B?Vzd6Qm83NTVrTXVtbjlRWmc1cnZESjIzSzVpVkdtM3BTRnJBaXF2SUhkN3Jn?=
 =?utf-8?Q?r/MlFM681E581abKHe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea367c7-c5c7-4714-714d-08dec7a990e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 11:07:03.1182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aG9kxmOtDVoTuJgI2B7mQSAx32U676w2IiUu9xEtwBKn99uI8HOcPHDtI+F3aQy4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2
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

On 6/11/26 11:50, Philipp Stanner wrote:
> On Thu, 2026-06-11 at 11:14 +0200, Christian König wrote:
>> On 6/11/26 10:35, Philipp Stanner wrote:
>>> On Wed, 2026-06-10 at 17:15 +0200, Christian König wrote:
>>>> On 6/10/26 16:25, Philipp Stanner wrote:
>>>>>
>>>>> Are you referring to this comment from the documentation?
>>>>>
>>>>>  * Since many implementations can call dma_fence_signal() even
>>>>> when before
>>>>>  * @enable_signaling has been called there's a race window,
>>>>> where the
>>>>>  * dma_fence_signal() might result in the final fence reference
>>>>> being
>>>>>  * released and its memory freed. To avoid this,
>>>>> implementations of this
>>>>>  * callback should grab their own reference using
>>>>> dma_fence_get(), to be
>>>>>  * released when the fence is signalled (through e.g. the
>>>>> interrupt
>>>>>  * handler).
>>>>>  *
>>>>>  * This callback is optional. If this callback is not present,
>>>>> then the
>>>>>  * driver must always have signaling enabled.
>>>>>  */
>>>>>  bool (*enable_signaling)(struct dma_fence *fence);
>>>>
>>>> Yes, that was an extremely bad idea which I have tried multiple
>>>> times to fix.
>>>
>>> What's the reason why enable_signaling() is nowadays called with
>>> lock-
>>> protection?
>>
>> That was some decision originally made a long long time ago because
>> the initial thought was that fence need to signal in order, but that
>> concept was also abandoned a long long time ago.
> 
> You also need it to avoid a race with the driver's requested signalling
> in ops->enable_signalling(), through dma_fence_add_callback().
> 
> I pointed that out in my answer. You cut it out and did not react to
> that statement.

Yeah because I don't think it's relevant.

You don't have a race between enabling signaling and adding the callback, that are two independent functions.

Enable signaling is something which must be done before adding the callbacks, that's granted but they don't need a common lock protection.

>> Fixing this is on my TODO list ever since we figured out that this
>> was a bad idea, see the latest patch set here as well:
>> https://www.spinics.net/lists/dri-devel/msg461253.html
>>
>>>>> Sure you can. If everything is properly synchronized.
>>>>>
>>>>> // driver
>>>>> dma_fence_signal(f);
>>>>> // all callbacks can't reach our driver anymore
>>>>
>>>> That's irrelevant. The question is not if a callback can reach
>>>> the backend after signaling.
>>>
>>> Irrelevant for your lock-inversion maybe. It's very relevant for
>>> life
>>> time and module unload. Proof: you and Tvrtko made
>>> dma_fence_signal()
>>> the decoupling point, with RCU protection.
>>>
>>> And as I keep saying, that synchronisation point would make the
>>> entire
>>> framework simpler and more robust if we were making it consistent.
>>
>> Exactly that's what I strongly disagree on.
> 
> Yeah, and you don't provide any rationale AFAICS. The argument
> basically is "this is how it is, and it is how it is because it is like
> that". It's "this is done with RCU instead of locks, because you can
> use RCU for that".
> 
> No offense intended, but I just can't see any substantial argument
> except for non-existing deadlocks that COULD ALREADY OCCUR and have to
> be mitigated by the drivers already.

Well those deadlocks absolutely do exists. I mean just take look at how bad the drivers have to work around the issue that enable_signaling and is_signaled can be called with the lock held.

>> The fence lock and the synchronization point which allows the driver
>> to know when nobody else is in a callback any more are two very
>> different things we should not be mixed up together.
> 
> Why? It's literally what locks exist for. For synchronization.

No, locks exists for protection of state.

> RCU has been literally developed for deadlock avoidance, which its
> usage in dma_fence provably doesn't achieve. You still have the
> deadlock problem, and on top of that you have redundant, unnecessary
> RCU calls.

Ok, where exactly do you see the problem? 

>> The fence lock protects the signaled state of the fence, so that the
>> fence functions can add callbacks, test signaling etc... while the
>> fence can't signal. It is protecting internal state of the fence and
>> so should be internal to the fence, external code should not touch it
>> if possible.
> 
> You allow people to take the lock manually with the API function
> dma_fence_lock_irqsave().
> 
> But you know what, I absolutely agree!
> 
> I think if we take the locks for the callbacks and remove
> dma_fence_set_error(), then the need to ever touch the lock manually
> disappears.

I agree on that but that makes it impossible for the dma_fence to independent of the driver who issues it.

> 
> Then the driver knows what I pointed out at least three times now:
> 
> dma_fence_signal(f);
> cleanup(f); // perfectly safe, bc after signal() all accesors are done
> 
> No RCU, no nothing. Just plain proper synchronization.

No, that doesn't work because you have multiple paths to dma_fence_signal():

A) Driver is calling that from IRQ.
B) Through calling dma_fence_enable_sw_signaling() and the underlying callback returning false.
C) Through calling dma_fence_is_signaled() and the underlying callback returning true.

For A you clearly can use that approach, but it mangles every attempt to cleanup for B & C because the driver can't grab locks which it would grab on path A.

It's really a picture book classic lock inversion problem with callbacks.

> But when I point that out, you say "No no, you can't do that, that's
> not the purpose of the lock, you have to do:
> 
> dma_fence_signal(f);
> call_rcu(cleanup(f));
> "
> 
> ???

Yes, what exactly is wrong with that? I mean you must have some kind of technical issue with that which I don't understand.

> 
>>
>> The synchronization point for the driver is a service the dma_fence
>> implementation offers to let drivers know when there is no more
>> caller of their function. And usually this is implemented using
>> RCU/SRCU.
> 
> "this is how it is because it is how it is".
> 
> The one and only reason why you need RCU is that you don't lock
> consistently.
> 
> Using RCU everywhere is nothing but symptom treatment.
> 
>>
>> Tvrko and I now choose RCU instead of SRCU because there didn't seem
>> to be a need to sleep in the fence callbacks.
> 
> You can't sleep in the callbacks, because the callbacks are invoked
> with the fence spinlock being held.

Yes which is the case at the moment, but that is something we want to get away from.

>>
>> But both RCU and SRCU offer not only synchronize_rcu()/_srcu() but
>> also call_rcu()/_srcu() which allows drivers to delegate the cleanup
>> to a point where it is save to do so.
> 
> "We use RCU instead of locks because we can use RCU instead of locks".
> This is not an argument against locks, Christian.
> 
> If you lock consistently, cleaning up after dma_fence_signal() is
> guaranteed to be safe to do, immediately.

Yes I agree on that, but you completely mess up all alternative signaling paths and that is something I can't accept.

>>
>> So while I see the problem I actually don't understand why you insist
>> of solving it with the fence lock?
> 
> Well, that's then a philosophical moment, because I on the contrary
> don't understand why you insist on solving it with RCU :D

Well because of the technical problems I see :D

> The tl;dr is: using the locks makes the entire implementation more
> robust and consistent and allows for removing the RCU delays.
> 
> I showed you a bug that would have been prevented with locks. It was
> caused by the improper synchronization, where dma_fence_is_signaled()
> can return true when the callbacks have not yet been run.

No, that problem wouldn't be fixed by that.

Even when we call the callbacks with the locks held has no effect on the handling in dma_fence_is_signaled().

We would also need to move the testing if a fence is signaled or not under the lock and I can guarantee you that there will be push back on this.

> The solution is to use
> 
> dma_fence_lock_irqsave(f);
> if (dma_fence_is_signaled_locked(f))
>   cleanup(f);
> dma_fence_unlock_irqrestore(f);
> 
> IOW… the solution is to call the ops->signaled() callback with the lock
> held……… notice something? ;)
> 
> I provided more rationale on the rest of my mail, but you cut that out.
> Here, let me repost it:
> 
> 
> "
> You need the lock for synchronization. To add the callback.
> 
> Basically, you came quite naturally to the same conclusion and solution
> as I did: you need / want race-free synchronization.
> 
> It's the exact same use-case, really. You want to prevent someone from
> interfering with the fence while the ops->callback is running. You need
> the lock for that, by definition.
> 
> The other two relevant callbacks, signaled() and set_deadline(),
> already have the same lock protection guarantee. The former through
> dma_fence_is_signaled_locked(), the latter through  the fact that
> everyone takes the lock immediately after callback begin anyways.
> "
> 
> and
> 
> "
> All we have to do is make the existing rules official and the code a
> bit more consistent.
> "
> 
> 
> The deadlock argument doesn't hold up because the lock is already being
> taken for enable_signalling() and signaled().
> 
> I showed you one Nouveau bug which the locks would have prevented.

Well I can clearly disproved that.

> Furthermore, I argue that it's impossible for you to remove the lock
> protection from ops->enable_signalling().

Yeah that is something I don't understand. Where exactly do you see the problem here?

We already have patches which does that which have been reviewed and tested and there wasn't any problem regarding that. It can be that we missed this because it was never pushed upstream.

> I further argue that consistent lock protection would allow for
> removing the need for dma_fence_is_signaled_locked() and
> dma_fence_lock_irqsave() as public APIs.

I agree that this goal would be nice to have, but I don't see how your proposal will help with that.

Regards,
Christian.

> 
> 
>>  That just brings us back to the bad design we had before where
>> internal fence state is abused to protect something else.
> 
> If we apply my design, we could deprecate dma_fence_lock_irqsave() and
> thereby declare it illegal to do that.
> 
> Relying on dma_fence_signal() being a point of synchronization is
> completely different from using its internal lock to protect your own
> list or tree or whatever.



> 
> 
> P.
> 
>>
>> Regards,
>> Christian.


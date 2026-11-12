Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C6606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QIOTUM6h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D6CC10E5F6;
	Thu, 12 Nov 2026 13:08:41 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BC110E5F6
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:08:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdGvmMWABJi9y0s+BvSCuC0+pbK7v/2VLn6Ydhz0EuJInRHnQM5p4ZEiVwZS8T3sO3BX7D/l/r9YeLUM+xBA8bZNgRHjyNHxe3rB6Wn0j/huiFFPbtKjFi2l7cAwTQtlLAkLM8S0yQR4HynTA30GFvf3MbR2lUXsNnEk8p7/78ntWfid/iej6ig0Q+bAecpyaDLwVIeGkiiGR4FmLDn1NhRcLjG6fL0esbVwARGlA3kGyKKQMOkDbl2STzLGyksoJejkXoE06woqo2p0IkDF8Eh69sIFZ1Grlst+kBp8VTkR+Tdkt8tS6KhCNcuLMVgW2GrfMytqKqNlOUokuRVcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLw/MVDcpFiWhee8nq29tdij25NWCXbZa9zCWT7VFJg=;
 b=U/YLze12n1ggnZTHu4KZOA6DOE8gk7oguXoNAFfNSUjSfQXrTIbIPKitUUbZZJEmhIkwtrER4p27knATGSVj60oqdgZdNQDkiqX/gt3k7omNr9ojQOugAOu7MKFIE8QCaHakSfOB0wrOGle+WL9KeAmZnbxdhOeoK5S7XoicZEV5eKGoZTHRFebbMGQWRT0ljP75qIirjEhiNiys/SSA4kbsmqdWvpA3f0dm78WvKwkIdpNsOvP9ymTkFanKED/g/j6QyHxT4zuvlHkEQE3QBxCO25+lsOMP524clWRCu+zgFdPpdr7aSQbhS+EcDmqTIZJlqXQQnE8dGo+MFskHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLw/MVDcpFiWhee8nq29tdij25NWCXbZa9zCWT7VFJg=;
 b=QIOTUM6hPmOZmL6xVqDOYbrQfxPOgj1k/akPWj4nz+ar8t8IXZdH51O5CWTt4GyV1/8HSbkT3GC1KeXCgOdSpaML70lBirzl5O0Ck46hOsrFoBNQ0nZQiYa3JbeZVx8VTlGSAKmWBJky28IdPiBbmrIfc7wZ9GNOnf7Hg/0SfJbs3CZDPVoDMUn481Mx1Wi8m3rOrJhc+6yNQ9JJ8lXhTB8fJ/Z8mcbseOOZoIP4/tR2qOYLebWpDaAF4ZN1dXM2tcGAsN48pBk0PUnDap4+Z9OnDyRA5TL2AdvcKtpOM1XPgrShbEtLQYLQ1mMrMJyKXrxk331kIOlaFeHCCgI72Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 13:07:10 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 13:07:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 22:07:06 +0900
Message-Id: <DMT976BWDM94.111ZSOZDKPBUO@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] gpu: nova-core: gsp: cmdq: increase
 MSGQ_NUM_PAGES to 64
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261112-msgq-64-pages-v2-0-bc1e6f7301ca@nvidia.com>
 <20261112-msgq-64-pages-v2-2-bc1e6f7301ca@nvidia.com>
In-Reply-To: <20261112-msgq-64-pages-v2-2-bc1e6f7301ca@nvidia.com>
X-ClientProxiedBy: TYWP286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f2984b-0c74-42ff-ea3f-08df40bddbf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|23010399003|366016|1800799024|10067099003|11063799006|4143699003|56012099006|261021135927099003|261026121527099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: VNckj1f8aY85HiSbCVHg4Hu+AQu0zLMFaSfIPdaH5jf1RmGYs6UIOT2M4SjMVS7o2GM+ZkwFfh7+Y+jj+irNirrJA9VRmyeM3SzVbAA/DUpX+Io8nYNpSgZVV7FHn1B3Ndtv/IutbLm34gN5UzcWdn6Z4Z4IYEiwGtMGTlTQ7iFiiS1cemUoPP+CTm4mUn4SbEJbzgTgC/KufZNxFVRxulBa3F8Br52JhBExJB8fkHtColK3WU4CbLD4Mny2SF7I5aMpT9/CugWbE7mvK2ex6XdjARcI3qhw/56FMOrr3TW5KbS8CzPgHa6iaDDXiTC1Rrv0rVI8ttFnLlqeH5Vux9+rzaLEArjaxvSvgOCYKtyQ0hlFXDlisElYioAMGF5+bN77JBw61uj59rKTcp8+9xC22BjuGJrH8If0t7kP3Pn6GhiF0zUu4pJxgMcy8OyR8xf5Bt9ecC9de8Hwz6Gge6QFFEJseNyRa5D2+vK33Rdq6boQ92IXCtVKcgT24M87jbPtee6csCTA+Ne1IYUXaRFsBT9SpmgCGcwdv23NUnOfe4Q5BtfO7k9R+sH3xKTtkpAZiRwttdQ1nU7OTUiBYYzHdX6b5E6T/ZAVeQaTpr8MTDBOPvfHx/8W7SU0XfxP102qmax3yHj8c2flrYgGfinfIUTkT0VzAFkqGuBBh5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261021135927099003)(261026121527099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjgrbG1Rb3RPclhWbjNQL0x0MWQrU0JtdytESkJjRk8xdVl0WXlKbGFjdkZ4?=
 =?utf-8?B?K2tVNUxHVVVvNWxtcDdaTXdESk1ZN1hSWFFNMmY4VkJ3bnhQSGJyQk9GLyt4?=
 =?utf-8?B?akhYSmNiaUNyVGh0V3h5clp0REFVOHo0OHhYMlViNUFTWktCczVyRGNSMXdQ?=
 =?utf-8?B?UXhDTG9HUTI5Q3k1Wk5OMEp0LzhQYm9WdTNhK28rWk8xSzlSWWFNQnpFQnk3?=
 =?utf-8?B?Ym5OTndKckIwRUtmQWJVQUJCaG1Edk5xL0FBMmY2VCtVdlJSbUtieFFEMFUv?=
 =?utf-8?B?bVZBeU9ybFp1K1kxMVRtcXBrZ2dNbjhqSTFDRmtyUWNPS0ZPeW5YVlpoNVZw?=
 =?utf-8?B?V1RUV2dlamJZTlBOSHU5S1NKNS9xYTNoLzVDd3hFT1h4VFdhczJ5dGVrUWM3?=
 =?utf-8?B?QlBMMExmeksvbjZURlBib0k1RFNUTzJvZFhpaFNxMnFTNkszdW1uNmR5SnlZ?=
 =?utf-8?B?VUpQU2htNkpGQ0pwejBscFBkSm5BcTlnbUNuNXhteEE1QUVBRkg5RTJrMUcy?=
 =?utf-8?B?Z2crQXR0VmZhK3NRVm1qRFhPdmdLOXZ2SExPR0Q3NktkY29paDhRWW40clov?=
 =?utf-8?B?L0lGc01FME1WQUU1TjBjNE4xaXdGbDJpUkpxcTU1V0JOUXVjNDlMUmR3ZHZj?=
 =?utf-8?B?OXRrd3BTeFVyRUlIelYxZnVLdTZZcFFzVkxmSFV2RzVadEpnNmZ6SWRvazFL?=
 =?utf-8?B?TXlmdDdOQ1I2WHkzbDVtVmJOS2VOL1lwYitvUXIvdEc4WlVmVTZ2SmJvK253?=
 =?utf-8?B?M1d6bXRram14bzdVd00zM01SV2V4Y2lzNlpMUDQ2aGl0WC85WWRtZS9Rb1A5?=
 =?utf-8?B?ckdVbmZsN2htVmNHNHEyQVlrWnJUOWhNYlBEeTY5aUdGZjFkK1J0dENhV20v?=
 =?utf-8?B?SEI5S2NIeUtkeTEwem5RU2ZRUDVEMUgrdCs0MDJHTlIwRk1SREM2ajNWTjlv?=
 =?utf-8?B?Ykttb21Wa29DeVJJSXJxRDhnQ3dNWDZOVnRXRGNsSGpJNnlsSUM1THpIUUhu?=
 =?utf-8?B?a2dNYlkxTXVrTnFiSWdnZWExYy9KY0VmbVI0S0FSOFJ2OWFETFhCVWx4eSs0?=
 =?utf-8?B?MDJJWjFLNjNwRU56K25FWkpheWJBQm1aVUtURTY2bUJiVDZiMzFrY1Nzd2E1?=
 =?utf-8?B?OUZvVFQzNWRsV2tFVlM4RXJzTVM0SjRyUlU0eFdMVVBxOGk0b2JGYkUrQ0h6?=
 =?utf-8?B?ZW5VK0dIQy8rQXgrUDFrTVRkem5MUXpZai9oSFQ5dTZlcnVQcHBSNnF4d25u?=
 =?utf-8?B?cWoxdFpISURhTUlsRlp4YVEzNDlaWXpuQjZTVytIZytBNzVpSjI2Sjlaa1F0?=
 =?utf-8?B?UGJuUXY4RktvMFRvQTRXcFFVWWY1cEorVVJXVWxjR0tRTGVzTFd5cHRJb0pC?=
 =?utf-8?B?STlrK21kSjBsRkc0SnN5b1JEK29lVHVvZ1QvOTNhWDJQbWFLNUZiUlpJYWhN?=
 =?utf-8?B?ODBEVFFERThRalM1Tk1yUGMxV2ZaS2JBbEZka2ZvUGVabExLRk1nN1JDTFha?=
 =?utf-8?B?SDkwcmpwS0VFc0VNT3NoTkZDQXlwZjdxVHl3Nkl0UzEwVkpNOGtCc2xxV05z?=
 =?utf-8?B?Vy80TEIrNnMxYVVoTUdWWnlUVU5OdzVsdk9VNnVFNWtCWWZMWTZtejdJai9B?=
 =?utf-8?B?dE0xbHQ1QXkvc21hQjR2U0N2MmszeTQ2MmZQb3FoVjVrZkxibWVQNnNNUmRJ?=
 =?utf-8?B?dU15SmxYd3FPWWpRTjNpQnpWRkhoRHVnSnpTRnAwUmdCaHE0V2tDVW05azQr?=
 =?utf-8?B?RTh6OFhrV0p3VjNDSUszTk1iOEhic01hS1FGNkw4OGZ0NW5IOVJ2cE42Y3dm?=
 =?utf-8?B?c3NRM1gyVitrbnZRYUxVcEhQLzVFVnJ3QytYRHN4MWIvS2IxYnJXSUZDTGpN?=
 =?utf-8?B?V21FTGtYejRGRkNMRUNRUVNpOGZaRWNqOElPUjRzRmtHenZQZWlRVnByVkRx?=
 =?utf-8?B?NFMzSEF3K25CNGtEc0pNcldzZThNNlVMK2Y4UDY5MkplZXR0WSsvdnQydnVG?=
 =?utf-8?B?YTZmVEFyMFZmWExiK3ZmNUNmYWhMODlSb2JoalJaZmNpMVlGRDFGSlVRSDFX?=
 =?utf-8?B?SUUwODdTbEdBRTYvSG1SclJ3WFYrbmlEcE5MYnQvTW85L2M1SDV4R1R3MThi?=
 =?utf-8?B?YUJaQUZJdXU3ZDhzNGZiRXUxcENTUkdLeEdCOU5aL29TeHcyaC81V21UaGJk?=
 =?utf-8?B?WTdoeHhXOTBZdjFnVmtXTnJnQ0lOeDh4ekF0YXVac1E1L0JNbUZDRTM0R1hS?=
 =?utf-8?B?YXloOWJUMVVDUzBZd2Z0MUxselgvTVpSTFpPSGhPWTlheFBIdnM3bE40djlL?=
 =?utf-8?B?ZGpiU08yakljMTcxVU9GeUU3c1owOFFjTWZWNUx4TndRYlVMWGxHNnB2Y0xT?=
 =?utf-8?Q?2n75w8djqa1Gw1Fz26OpOLf8/AApVWxJXmOW0+bnjd415?=
X-MS-Exchange-AntiSpam-MessageData-1: 4d9ASAqu11MG4Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f2984b-0c74-42ff-ea3f-08df40bddbf9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:07:09.5332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Av/vMepp5v26/MjE/tcpNrrG0w+RNE96+MAIDGR46EuPf9ZV6gYIc+hA8g5A7bOLGW4Y9zY+hkgiEcq9a4GJtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 3:14 PM JST, Eliot Courtney wrote:
> In the msgq v2 protocol, which the r000 firmware uses, the queue
> pointers are kept in u32 registers and increase monotonically until they
> wrap at 2^32.
>
> `MSGQ_NUM_PAGES` is currently 63 and does not divide 2^32. This means
> that on msgq v2, the slot can jump backwards when the counters wrap.
> For example:
>
>     (2^32 - 2) % 63 =3D=3D 2
>     (2^32 - 1) % 63 =3D=3D 3
>              0 % 63 =3D=3D 0    (slot 0 instead of slot 4)
>
> The writer can then overwrite slots before the reader has read them.
>
> Increase `MSGQ_NUM_PAGES` to 64 and check at compile time that
> `MSGQ_NUM_PAGES` divides 2^32.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

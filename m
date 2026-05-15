Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CECACD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9943B10E0CF;
	Fri, 15 May 2026 09:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="dQYHBp41";
	dkim-atps=neutral
Received: from SY8PR01CU002.outbound.protection.outlook.com
 (mail-australiaeastazolkn19010075.outbound.protection.outlook.com
 [52.103.72.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F1610E0CF
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tt+C4Gjj4x8L7tvEy6CuysWspO3UWtbGcpa2ddzdsYJmA5FbmUSJ6McNC8XWs3OF1LPrgsfVMm4FmPd7DFuwABo6mFvRGEvXZduU5+lYlsu4tWgtLaXBx3SrGmsw/62eMXSoQc/py9aOZK1lH9CZxXTqg+ZqRpNbwfGymKn/5ZFl+KRUC6Ji/vO/JrQHcbA8ndj295021xsr0bde49RDsAXH7+De7reegIuPyrnkC6AObQooxlk10NyUKXLLLkQ6tbEPlPmSt/Z12VU9tAYDErWAkaXMDcPNecxe9CYG7kFsDBflWqxlUfmm2AssDXC6U//duXwQ6WBNqCHb6cTw7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTH+kRt+3gqjIzKfMXGexkgWXGv50dwPfmox1sJJnSA=;
 b=ExxxuBY7CdSgCVlOAeqKCscBgw0jKVC7GHhfPC5VnsD+XzQOmoyt+/qDUR9paZobPILn056lupVIwqZ0FUg3DOq1uCGmdDpMrSP1DBX1n9BVWfAUJZDjwdiPUte1a1FfpnZhFbkcleYK0Qn0dDbAFKuddbpBJku+CdQQKe2bcDIJxr521b9fGaaJ+QSPfDvVKxNU1ijGH2A6JbaWenjDa9izQnFkaVm7WVUzUcDFjxlkUR8WKsziXGMXZMfZSjO8oGP3ueu7t5aDw6Dik/jtloX3nC1/1yAUYC9MmcV3385xQc9lcosD5XgI6Cpwn3Hd5C8xDRSGLEWMyVxqCz2Sxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTH+kRt+3gqjIzKfMXGexkgWXGv50dwPfmox1sJJnSA=;
 b=dQYHBp41BLRaiLmRnuZeHsYIqFzitOWI7x2WnXvFFNKTev846vi7U283v1BAD6AUBMsh8PK0wWFdz1m9MzbtLIr8LG2Zfb61mYATiWxm8bpSWTpLQu/da2PRmH/EoeCpF8ix2/5vhiKRVJTkFaIH2941g7f0UZKksa5269nyp1XIeOCGWSrS+F90l6cvjlUiqg7FsUCOUsLtZYko22fGMKVPwQq8I+zQeLqz+b8Mo3QJbpdOVL9FRZDYZfZ/037dpXwKZYd7aDkeXFzeiK4sVYxRXW23v6gEOXR57IqtHuaJTtgqOwuhopfHy9xJdtWEXm2ge95sRMtXpJD5pF2knw==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY9PR01MB11031.ausprd01.prod.outlook.com (2603:10c6:10:323::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 09:17:14 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 09:17:14 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Fri, 15 May 2026 17:16:03 +0800
Subject: [PATCH] misc: fastrpc: fix DMA address corruption due to find_vma
 misuse
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <SYBPR01MB78819393A1F4FA658B2AB076AF042@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAFLkBmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0NT3bTMitRiXQMDc8NEU0sjS8tUUyWg2oKiVLAEUGl0bG0tAMTflQp
 XAAAA
X-Change-ID: 20260515-fixes-0071a59299e5
To: Srinivas Kandagatla <srini@kernel.org>, 
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=HYfAoouaWF48muOf3K2vQvoKmzyJXDLag48ZwcWoLXQ=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGLLYnQUqmtqJ/tIrTz8jPnFCxo819851iT7dnJ6ea/
 ozZK2Gr1NJRysIgxsUgK6bIcrzg0jcL3y26W3y2JMPMYWUCGcLAxSkAE3lmwvDfRyX3gLix/5o3
 giu0Vsz19Zhy4/9URxUnhjk55RtXsmo7M/zT4A/w235z1c/2jW8cr5zKqNp+79Eav2m3FCv3yMu
 I3jDiAwDio0nw
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TYCP301CA0085.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::7) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID: <20260515-fixes-v1-1-26d6ead8b8d9@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY9PR01MB11031:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f9f053-cfc7-4316-c30e-08deb262c06a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|15080799012|23021999003|41001999006|8060799015|5072599009|51005399006|24021099003|6090799003|55001999006|5062599005|24121999003|22091999003|440099028|3412199025|31101999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTRlbkFob0Mvcyttdmtad25LZnJVUFJEVlQxUHJFUXBIVEZQZFRXTlBQVjR2?=
 =?utf-8?B?K2tDSHZhaGhtSGQvY2VveXRGbWxXTVhSZ0tCWTBOaDFOL3RVcTl4a1pqN050?=
 =?utf-8?B?cnNxaXdlVnIzZlB0THBEM1pPcVRjWjVWbFZSNXZMYk84aDBjUERSNjBiZzdv?=
 =?utf-8?B?TEZaZ3dVaEtzZGVSYXhXYlJFMy94cVpJRFhrV1VwTk1oOHE0bWRMRXlrd3ZZ?=
 =?utf-8?B?d1FpVlV1bW52ODZ1N1lReEdjd0QvK0ZIZVE4dVlzRi9YdzRvY2p5RG9FQkNk?=
 =?utf-8?B?MVFVQTlmWndaVjQ0aDBIbWtiMUFzS2tQNDVIS1ZaTWtteVRNODVNT2JLalNn?=
 =?utf-8?B?YlkyTm05VXV2TkY0eVRTVFQ2TTQ2UmZIRExpM3h0eWJzb3VjWVhyZnpnaDhy?=
 =?utf-8?B?eG52cEIzTUZ6RHI1UmxhRFhVYTFaeEhTY09paVlqQTZsM0JoNi9EVVZvTzRN?=
 =?utf-8?B?VVloM0RhYzY4ZEc0ZnV1NEVWc3lwUktibmxST2ZLRnhhVXFNS1F2TDE0K1VD?=
 =?utf-8?B?U1lsYnVEMVljYUp6MDBHVk5DaGI0L1JiaGRZb1dpb05GYWIrNWNWNFI2anJp?=
 =?utf-8?B?eWFOc1lPcmQ0Z2hjSnR2dDRLL3ZaMTI3UzJHNVBqa0NkeCtFbzg3eFAxNklo?=
 =?utf-8?B?SFNVWCtQeG1sYzJQWHdYNThoYk5HVDFEb3NERkxDQjRGMlNWbUphU0YwdGNl?=
 =?utf-8?B?OG1jRnZXcDZxaXpZSWhxazRCUHZzWXBRalBHMmxGU1R1d24rRmgrYklJT1dm?=
 =?utf-8?B?dUxoV2xGYUx5RVJhcHFXeUNZZFBheWViM0NGcy8zQzNvWlVkQ1FTZ1JMcVVB?=
 =?utf-8?B?LzQreDZ3U1A1THExUU5MTHZ2cTJ2QmlJTUdKT1FYTkNzUFJOaksxNzJlTEVt?=
 =?utf-8?B?dUJNZFd2S2ZnYUx5YUJXbjdzemlhcEx2QlUrTFNFNWQ0SUtwelQySFhDVmRs?=
 =?utf-8?B?b21sL0VLcHJ0NFdPaWpWaU4rYTZMYXpiVVhFNXp0OUVzcHk3eWZPV3JwdytJ?=
 =?utf-8?B?Rmw5MDBEdDNIRXMyOUlyL3pkVStCS3R3OERaUStmdDdCMjZwK0NjRHNycEJ1?=
 =?utf-8?B?K0NMSU5tRmpTRGt0cGloM0RMcjd2Zkx4aWVQSFhBMnljeHJObHQ3dWx4NlFL?=
 =?utf-8?B?S3d2Ym5jWk1YZ3hZR1NlVTRiYlJCT055K3RRUXEvYUcxR3AzNzlEamQ3T3Q2?=
 =?utf-8?B?UTNxNGQ0S1JGUGFJTG5ReHNUL3FobTBoaHRCNmJodSsxVWtFRTJKUVVZdFg5?=
 =?utf-8?B?TURGOEk0SXgxbmVSRG9QKzlkRGFQQWh2R2FMWk91aXhXRjcyWnZYemRhYklJ?=
 =?utf-8?B?aVBUYi9aMUNxa1F1cVh2dGhRN1orM0JoZWlhRndYUlMwYWMrdXBOVkJMeHV0?=
 =?utf-8?B?Q1phQ3FGRjM5eWFOcHpLQXJQK21IKzdnanNEaCtieUMrdlB3cUZ4UVg0TDlC?=
 =?utf-8?B?bENUdHFDTkE3Ny9Wdnlwd0FpODFuUzFHN1EyenArSXYzaXBjc1NPOHRMNHVB?=
 =?utf-8?B?L1dXL0lBUEFZZzRjQ08zaUJXdERCdGlhU0ZuUy93TlJLdlRjN3JyVjJGWmpS?=
 =?utf-8?Q?ZiEJK29Nj8rZwidm/9/zP/9O0mkdmj5umRkQu4w7AT8Tlo?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3Rha0tqWWQ1ZmxxMW13dGd2TEZRSHFaUFMwZGlyNjdreXE3Y0hDc204cWlI?=
 =?utf-8?B?cTRTWUFCYW1OQWxqOVoxZnJOeDVGL3o1VHdmMHR4QnNTZStXYVVrVHNRSXky?=
 =?utf-8?B?NFJod2dWV1NjbFFNVmlTUmphdnd3UkxaQjhDRUFnVmdzS3ZxY3BKbFFyT0xS?=
 =?utf-8?B?clNGaG53LzhDZHQrUkRuaHQ5aExZVlljV1dQaUxKWHg1M3lLMEgzV0J2R1kx?=
 =?utf-8?B?cG1uRkxodFJXTjEvUFdpa0hTZy83UkFpUmVNYVhGNitpVFdNTUw1VERHRHhP?=
 =?utf-8?B?QVFtZlpQTmNCNnVLRnNvK1pjd3R1bWRyRmd6QmJWbUkyUVZBU1REU1N1SkVP?=
 =?utf-8?B?Y2JQZkQvYit4c3FIWGN3MUdtcEhGZjZhZDBPblFQODJGb0ZaaTRPY3VWd2xu?=
 =?utf-8?B?cXdrZGh5dUpyVHhqSVZhejY4eFp3dEhtejkxbHBxZFZHVXBIYWtMRmxVYkRV?=
 =?utf-8?B?dXpDL280UUtxbFJxdkNxd0kyZ1NlNlNiSXNxMDc2UUw4MS9LVEU3U3NNU0dV?=
 =?utf-8?B?ek9ob3cxOEgyeTBRMTB1Q3NSVXZwVUxRMEVoVERCOE5Gc2QwbUhvVWdHNm96?=
 =?utf-8?B?b2lrRUYrcGZRcm5lZGtYOENnWWxnOGFOaStNK3dyUXFSdGZTNmZzd2Y4NzV2?=
 =?utf-8?B?SWw3blk0UERVenhJYUJaTk43ekg2d0RCTWVTb1JMek1IaXExYlE0ZGlHc1Jr?=
 =?utf-8?B?alE1Y3pZUVJrb1lMTkFuSjBaZVF1OUJJU1NZNnNzT05sZVljakgrc1NSKzNJ?=
 =?utf-8?B?amtFTWd2Y1FwRFI5ZWJ0TFpFNGFld3I1azd1djFsY3BGRWFiT1JUU251V2c2?=
 =?utf-8?B?TW5YUUNxY1hxcmxGVmtybDdJcTR0ZFhKaUtLRk9NUC9tYThzMGdTRVozNFVN?=
 =?utf-8?B?WGFGTTNidlhTVjIwK1lqUkwrZXJoMzdCWlJkY3E5VGphOXorZFAzcG15cSsw?=
 =?utf-8?B?NmRiK1FrMFRWVzJGSDYvT3pBSXFoMCtRWWVjM0xSZ2xGcmJPRGkwU2JqU1Rl?=
 =?utf-8?B?clN4K3BXTjVmdG5BalJpYVZ6djdlclBRS3NrWS9GdGlYd2V3L2dHVUg5bjZY?=
 =?utf-8?B?RnNma1NtVk1weFFPZXJLMHFya05VSkFLbTNpVlRObkUzcE1WQWZ4S0ltcWU5?=
 =?utf-8?B?S2UvOXJxcHBtTjZ0WXJueFZkL0xiQ054SFNzR3FPT3pFeEFzb1daVkRUWmtR?=
 =?utf-8?B?YWFZcXIyMTVVNFJKaHN3Z1hPNnNZMytvYXpPM3RuTnJyckFEK2x0TCs5eXJN?=
 =?utf-8?B?V0xvUE9sa1h4SnJyU05oTDBZT2RqWm5iTjJ5K0gxc1d5RnlWM01QT0dTR2wr?=
 =?utf-8?B?dGgvTTczL2VwNHJpZ0hITGtVZldWaFBqd1FZMTArTnR3V252alg5dVdob3Vj?=
 =?utf-8?B?eFVJL2JoU2s4TjBvV2x3U2NDd3doekRTMlhTb2J1M1c4QkR5UEhENW9DOHBB?=
 =?utf-8?B?QUtPdmE5aFJoSjdnd2YrVkc2M1A0SnR0amRLaXFJMGhCYVhlVER0dEVJSE9E?=
 =?utf-8?B?d0RLdE5WK21QMS9TWnB4ZElRUS85eVU5SkI3UDVoZk9jVjlveXhLa2JwWU9I?=
 =?utf-8?B?dXBlV0ErTlpiUTFJb0NPbzVEVXZkdlhOazBVQjVwZUxEMzh4STAxakpTbWpW?=
 =?utf-8?B?UWQ4N0VBNy9jZ1IxVDMrZnpDQ1dZaTNmVGlEdmo5cVZkSjV3QmhpWHVHa2xs?=
 =?utf-8?B?NnJHUTV1R3IrN1kwZDI4aHYreThGeGhSdWxoeHNRUW9tT2x0bVdYZnd0OGZn?=
 =?utf-8?B?WDJsRW04NDVQQjRLK0c1UXc4cWpWaVZUWHBmS1FQYUh1eDZYd25oYUVKdHRt?=
 =?utf-8?B?L1lGeXlwOTlOVEFVUmFuMXJTTkVFZmJsTGc4VzBseXA3dU1Tc0pMMlFxdTBE?=
 =?utf-8?B?R1Ryb3RQRFdockZaZEpVYWt6dzhNWmkydi9rL00yTFdSbVE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f9f053-cfc7-4316-c30e-08deb262c06a
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 09:17:14.3534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9PR01MB11031
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

fastrpc_get_args() uses find_vma() to look up the VMA for a user-provided
pointer and compute a DMA address offset. When the address falls in a gap
before the returned VMA, (ptr & PAGE_MASK) - vma->vm_start underflows,
corrupting the DMA address sent to the DSP.

Replace find_vma() with vma_lookup(), which returns NULL when the address
is not contained within any VMA.

Cc: stable@vger.kernel.org
Fixes: 80f3afd72bd4 ("misc: fastrpc: consider address offset before sending to DSP")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 47356a5d5804..31b709fe6ed1 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1041,7 +1041,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			pages[i].addr = ctx->maps[i]->dma_addr;
 
 			mmap_read_lock(current->mm);
-			vma = find_vma(current->mm, ctx->args[i].ptr);
+			vma = vma_lookup(current->mm, ctx->args[i].ptr);
 			if (vma)
 				pages[i].addr += (ctx->args[i].ptr & PAGE_MASK) -
 						 vma->vm_start;

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260515-fixes-0071a59299e5

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>

